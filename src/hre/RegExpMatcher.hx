package hre;

import haxe.ds.Either;
import hre.RegExpMatcher.MatcherResult;
import hre.RegExpMatcher.MatcherState;
import hre.RegExpMatcher;
import hre.ast.Alternative;
import hre.ast.Assertion in AssertionNode;
import hre.ast.Atom in AtomNode;
import hre.ast.CharacterClass;
import hre.ast.CharacterClassAtom;
import hre.ast.CharacterClassRange;
import hre.ast.Disjunction;
import hre.ast.Pattern;
import hre.ast.Quantifier;
import hre.ast.Term in TermNode;
import tink.core.Error;

enum MatcherResult {
  Failure;
  Success(matcherState:MatcherState);
}

typedef Continuation = MatcherState -> MatcherResult;
typedef AssertionTester = MatcherState -> Bool;
typedef Matcher = MatcherState -> Continuation -> MatcherResult;
typedef PatternMatcher = String -> Int -> MatcherResult;

class MatcherState {
  public var index:Int;
  public var length:Int;
  public var ignoreCase:Bool;
  public var multiline:Bool;
  public var unicode:Bool;
  // The string being matched
  public var list:Array<Int>;
  public var captures:Array<String>;

  public function new() {

  }

  public function copy():MatcherState {
    var result:MatcherState = new MatcherState();
    result.index = this.index;
    result.length = this.length;
    result.ignoreCase = this.ignoreCase;
    result.multiline = this.multiline;
    result.unicode = this.unicode;
    result.list = this.list.copy();
    result.captures = this.captures.copy();
    return result;
  }
}

class RegExpMatcher {
  public function new() {
  }

  public static function evaluatePattern(pattern:Pattern, flags:RegExpFlags):PatternMatcher {
    return function(source:String, index:Int):MatcherResult {
      if (!(index <= source.length)) {
        throw new Error("Assertion `index <= source.length` failed");
      }
      var state:MatcherState = new MatcherState();
      state.length = source.length;
      state.list = [];
      for (i in 0...source.length) {
        state.list.push(source.charCodeAt(i));
      }
      state.index = index;
      state.multiline = flags.multiline;
      state.ignoreCase = flags.ignoreCase;
      state.unicode = flags.unicode;
      state.captures = [];
      for (_ in 0...pattern.captures) {
        state.captures.push(null);
      }

      var m:Matcher = RegExpMatcher.evaluateDisjunction(pattern);

      var continuation:Continuation = function(state:MatcherState):MatcherResult {
        return MatcherResult.Success(state);
      }

      return m(state, continuation);
    }
  }

  public static function evaluateDisjunction(disjunction:Disjunction):Matcher {
    var alternativeMatchers:Array<Matcher> = disjunction.alternatives.map(RegExpMatcher.evaluateAlternative);
    return function(state:MatcherState, continuation:Continuation):MatcherResult {
      if (alternativeMatchers.length == 0) {
        return continuation(state);
      }
      for (matcher in alternativeMatchers) {
        var r = matcher(state, continuation);
        switch (r) {
          case MatcherResult.Failure: continue;
          default: return r;
        }
      }
      return MatcherResult.Failure;
    }
  }

  public static function evaluateAlternative(alternative:Alternative):Matcher {
    return function(state:MatcherState, continuation:Continuation) {
      var c:Continuation = continuation;
      var idx = alternative.terms.length;
      while (idx > 0) {
        idx--;
        var m:Matcher = RegExpMatcher.evaluateTerm(alternative.terms[idx]);
        var nextContinuation:Continuation = c;
        c = function(s:MatcherState) {
          return m(s, nextContinuation);
        }
      }
      return c(state);
    }
  }

  public static function evaluateTerm(term:TermNode):Matcher {
    return switch(term) {
      case TermNode.Assertion(assertion):
        function(state:MatcherState, continuation:Continuation):MatcherResult {
          // TODO: Evaluate before execution
          return switch(RegExpMatcher.evaluateAssertion(assertion)) {
            case Either.Left(assertionTester):
              if (assertionTester(state)) {
                continuation(state);
              } else {
                MatcherResult.Failure;
              }
            case Either.Right(matcher):
              matcher(state, continuation);
          }

        }
      case TermNode.Atom(atom):
        return RegExpMatcher.evaluateAtom(atom);
      case TermNode.QuantifiedAtom(atom, quantifier, captureStart, captureEnd):
        return RegExpMatcher.evaluateQuantifiedAtom(atom, quantifier, captureStart, captureEnd);
    }
  }

  public static function evaluateAssertion(assertion:AssertionNode):Either<AssertionTester, Matcher> {
    return switch (assertion) {
      case AssertionNode.StartOfText:
        Either.Left(function(state:MatcherState):Bool {
          var e:Int = state.index;
          if (e == 0) {
            return true;
          }
          if (!state.multiline) {
            return false;
          }
          if (RegExpMatcher.isLineTerminator(state.list[e - 1])) {
            return true;
          }
          return false;
        });
      case AssertionNode.EndOfText:
        Either.Left(function(state:MatcherState):Bool {
          if (state.index == state.length) {
            return true;
          }
          if (!state.multiline) {
            return false;
          }
          if (RegExpMatcher.isLineTerminator(state.list[state.index])) {
            return true;
          }
          return false;
        });
      case AssertionNode.WordBoundary:
        Either.Left(function(state:MatcherState):Bool {
          var e:Int = state.index;
          var a:Bool = e > 0 && RegExpMatcher.isWordChar(state.list[e - 1]);
          var b:Bool = e < state.length && RegExpMatcher.isWordChar(state.list[e]);
          return !(a == b);
        });
      case AssertionNode.NotWordBoundary:
        Either.Left(function(state:MatcherState):Bool {
          var e:Int = state.index;
          var a:Bool = e > 0 && RegExpMatcher.isWordChar(state.list[e - 1]);
          var b:Bool = e < state.length && RegExpMatcher.isWordChar(state.list[e]);
          return a == b;
        });
      case AssertionNode.FollowedBy(disjunction):
        var m:Matcher = RegExpMatcher.evaluateDisjunction(disjunction);
        Either.Right(function(state:MatcherState, continuation:Continuation):MatcherResult {
          var d:Continuation = function(state:MatcherState) {
            return MatcherResult.Success(state);
          }
          return switch (m(state, d)) {
            case MatcherResult.Failure:
              MatcherResult.Failure;
            case MatcherResult.Success(subState):
              var nextState:MatcherState = subState.copy();
              nextState.index = state.index;
              continuation(nextState);
          }
        });
      case AssertionNode.NotFollowedBy(disjunction):
        var m:Matcher = RegExpMatcher.evaluateDisjunction(disjunction);
        Either.Right(function(state:MatcherState, continuation:Continuation):MatcherResult {
          var d:Continuation = function(state:MatcherState) {
            return MatcherResult.Success(state);
          }
          return switch (m(state, d)) {
            case MatcherResult.Failure:
              continuation(state);
            case MatcherResult.Success(_):
              MatcherResult.Failure;
          }
        });
    }
  }

  public static function evaluateAtom(atom:AtomNode):Matcher {
    return switch(atom) {
      case AtomNode.Literal(literal):
        RegExpMatcher.characterSetMatcher([literal.charCodeAt(0)], false);
      case AtomNode.Class(characterClass):
        RegExpMatcher.evaluateCharacterClass(characterClass);
      case AtomNode.SimpleGroup(disjunction):
        RegExpMatcher.evaluateDisjunction(disjunction);
      case AtomNode.CaptureGroup(disjunction, captureIndex):
        RegExpMatcher.evaluateCaptureGroup(disjunction, captureIndex);
      case AtomNode.Backreference(captureId):
        RegExpMatcher.evaluateBackreference(captureId);
      case AtomNode.AnyCharacter:
        RegExpMatcher.characterSetMatcher(RegExpMatcher.lineTerminators, true);
      case AtomNode.Decimal:
        function(state:MatcherState, continuation:Continuation):MatcherResult {
          var e:Int = state.index;
          if (e == state.length) {
            return MatcherResult.Failure;
          }
          var cc:Int = RegExpMatcher.canonicalize(state, state.list[e]);
          if (0x30 <= cc && cc <= 0x39) {
            var nextState = state.copy();
            nextState.index++;
            return continuation(nextState);
          } else {
            return MatcherResult.Failure;
          }
        }
      case AtomNode.NotDecimal:
        function(state:MatcherState, continuation:Continuation):MatcherResult {
          var e:Int = state.index;
          if (e == state.length) {
            return MatcherResult.Failure;
          }
          var cc:Int = RegExpMatcher.canonicalize(state, state.list[e]);
          if (!(0x30 <= cc && cc <= 0x39)) {
            var nextState = state.copy();
            nextState.index++;
            return continuation(nextState);
          } else {
            return MatcherResult.Failure;
          }
        }
      case AtomNode.Word:
        function(state:MatcherState, continuation:Continuation):MatcherResult {
          var e:Int = state.index;
          if (e == state.length) {
            return MatcherResult.Failure;
          }
          var cc:Int = RegExpMatcher.canonicalize(state, state.list[e]);
          if (RegExpMatcher.isWordChar(cc)) {
            var nextState = state.copy();
            nextState.index++;
            return continuation(nextState);
          } else {
            return MatcherResult.Failure;
          }
        }
      case AtomNode.NotWord:
        function(state:MatcherState, continuation:Continuation):MatcherResult {
          var e:Int = state.index;
          if (e == state.length) {
            return MatcherResult.Failure;
          }
          var cc:Int = RegExpMatcher.canonicalize(state, state.list[e]);
          if (!RegExpMatcher.isWordChar(cc)) {
            var nextState = state.copy();
            nextState.index++;
            return continuation(nextState);
          } else {
            return MatcherResult.Failure;
          }
        }
      case AtomNode.Separator:
        RegExpMatcher.characterSetMatcher(RegExpMatcher.separators, false);
      case AtomNode.NotSeparator:
        RegExpMatcher.characterSetMatcher(RegExpMatcher.separators, true);
    }
  }

  /**
   * The quantified atom contains the capture groups with 0-based index `captureId` such as:
   * `captureStart <= captureId < captureEnd`.
   */
  public static function evaluateQuantifiedAtom(atom:AtomNode, quantifier:Quantifier, captureStart:Int, captureEnd:Int):Matcher {
    var m:Matcher = RegExpMatcher.evaluateAtom(atom);
    return function(state:MatcherState, continuation:Continuation):MatcherResult {
      return RegExpMatcher.repeatMatcher(m, quantifier.min, quantifier.max, quantifier.greedy, state, continuation, captureStart, captureEnd);
    }
  }

  public static function repeatMatcher(m:Matcher, min:Int, max:Int, greedy:Bool, x:MatcherState, c:Continuation, captureStart:Int, captureEnd:Int):MatcherResult {
    if (max == 0) {
      return c(x);
    }
    var d:Continuation = function(y:MatcherState) {
      if (min == 0 && x.index == y.index) {
        return MatcherResult.Failure;
      }
      var min2 = min == 0 ? 0 : min - 1;
      var max2 = max == -1 ? -1 : max - 1;
      return RegExpMatcher.repeatMatcher(m, min2, max2, greedy, y, c, captureStart, captureEnd);
    }
    var xr:MatcherState = x.copy();
    for (k in captureStart...captureEnd) {
      xr.captures[k] = null;
    }
    if (min > 0) {
      return m(xr, d);
    }
    if (!greedy) {
      var z = c(x);
      return switch (z) {
        case MatcherResult.Failure:
          m(xr, d);
        default:
          z;
      }
    }
    var z = m(xr, d);
    return switch (z) {
      case MatcherResult.Failure:
        c(x);
      default:
        z;
    }
  }

  public static function evaluateCaptureGroup(disjunction:Disjunction, captureIndex:Int):Matcher {
    var m:Matcher = RegExpMatcher.evaluateDisjunction(disjunction);
    return function(state:MatcherState, continuation:Continuation):MatcherResult {
      var subContinuation:Continuation = function(subState:MatcherState) {
        var capturedSubstring = "";
        for (i in state.index...subState.index) {
          capturedSubstring += String.fromCharCode(state.list[i]);
        }
        var nextState = subState.copy(); // Creates a new captures array
        nextState.captures[captureIndex] = capturedSubstring;
        return continuation(nextState);
      }
      return m(state, subContinuation);
    }
  }

  public static function evaluateBackreference(captureId:Int):Matcher {
    var captureIndex = captureId - 1;
    // TODO: syntax error if captureIndex >= pattern.captureCount
    return function(state:MatcherState, continuation:Continuation):MatcherResult {
      var referenced = state.captures[captureIndex];
      if (referenced == null) {
        return continuation(state);
      }
      var e = state.index;
      var f = e + referenced.length;
      if (f > state.list.length) {
        return MatcherResult.Failure;
      }
      for (i in 0...referenced.length) {
        if (RegExpMatcher.canonicalize(state, state.list[e + i]) != RegExpMatcher.canonicalize(state, referenced.charCodeAt(i))) {
          return MatcherResult.Failure;
        }
      }
      var y:MatcherState = state.copy();
      y.index = f;
      return continuation(y);
    }
  }

  public static function evaluateCharacterClass(characterClass:CharacterClass):Matcher {
    return function(state:MatcherState, continuation:Continuation):MatcherResult {
      var e:Int = state.index;
      if (e == state.length) {
        return MatcherResult.Failure;
      }
      var cc:Int = RegExpMatcher.canonicalize(state, state.list[e]);
      var matched:Bool = false;

      for (range in characterClass.ranges) {
        switch(range) {
          case CharacterClassRange.Range(start, end):
            var startCode = start.charCodeAt(0);
            var endCode = end.charCodeAt(0);
            if (state.ignoreCase) {
              for(i in startCode...endCode+1) {
                if(cc == RegExpMatcher.canonicalize(state, i)) {
                  matched = true;
                  break;
                }
              }
            } else {
              if (startCode <= cc && cc <= endCode) {
                matched = true;
                break;
              }
            }
          case CharacterClassRange.Simple(ccAtom):
            switch(ccAtom) {
              case CharacterClassAtom.Literal(value):
                if (RegExpMatcher.canonicalize(state, value.charCodeAt(0)) == cc) {
                  matched = true;
                  break;
                }
              case CharacterClassAtom.Decimal:
                if (0x30 <= cc && cc <= 0x39) {
                  matched = true;
                  break;
                }
              case CharacterClassAtom.NotDecimal:
                if (!(0x30 <= cc && cc <= 0x39)) {
                  matched = true;
                  break;
                }
              case CharacterClassAtom.Separator:
                if (RegExpMatcher.separators.indexOf(cc) >= 0) {
                  matched = true;
                  break;
                }
              case CharacterClassAtom.NotSeparator:
                if (RegExpMatcher.separators.indexOf(cc) < 0) {
                  matched = true;
                  break;
                }
              case CharacterClassAtom.Word:
                if (RegExpMatcher.isWordChar(cc)) {
                  matched = true;
                  break;
                }
              case CharacterClassAtom.NotWord:
                if (!RegExpMatcher.isWordChar(cc)) {
                  matched = true;
                  break;
                }
            }
        }
      }

      if (characterClass.inverted == matched) {
        return MatcherResult.Failure;
      }
      var nextState = state.copy();
      nextState.index++;
      return continuation(nextState);
    }
  }

  public static function characterSetMatcher(codepoints:Array<Int>, invert:Bool):Matcher {
    return function(state:MatcherState, continuation:Continuation):MatcherResult {
      var e:Int = state.index;
      if (e == state.length) {
        return MatcherResult.Failure;
      }
      var cc:Int = RegExpMatcher.canonicalize(state, state.list[e]);
      var matched:Bool = false;
      for (chr in codepoints) {
        if (cc == RegExpMatcher.canonicalize(state, chr)) {
          matched = true;
          break;
        }
      }
      if (invert == matched) {
        return MatcherResult.Failure;
      }
      var nextState = state.copy();
      nextState.index++;
      return continuation(nextState);
    }
  }

  // TODO: options like "ignoreCase" should not be part of the state
  public static function canonicalize(state:MatcherState, codepoint:Int):Int {
    if (!state.ignoreCase) {
      return codepoint;
    }
    // TODO: use unicode database for simple folding, http://unicode.org/Public/UCD/latest/ucd/CaseFolding.txt
    return String.fromCharCode(codepoint).toLowerCase().charCodeAt(0);
  }

  /**
   * Returns `true` if the provided codepoint corresponds to one of the following codepoints:
   * - Unicode Character 'LINE FEED (LF)' (U+000A)
   * - Unicode Character 'CARRIAGE RETURN (CR)' (U+000D)
   * - Unicode Character 'LINE SEPARATOR' (U+2028)
   * - Unicode Character 'PARAGRAPH SEPARATOR' (U+2029)
   *
   * @see <http://www.ecma-international.org/ecma-262/7.0/index.html#prod-LineTerminator>
   */
  public static function isLineTerminator(codepoint:Int):Bool {
    return RegExpMatcher.lineTerminators.indexOf(codepoint) >= 0;
  }

  /**
   * Returns `true` if the provided code point corresponds to one of the following 63 characters:
   *
   * ```text
   * abcdefghijklmnopqrstuvwxyz
   * ABCDEFGHIJKLMNOPQRSTUVWXYZ
   * 0123456789_
   * ```
   *
   * THIS IS NOT THE ABSTRACT METHODE DESCRIBED IN THE SPEC!!!
   * (It is just a helper for the allowed characters)
   *
   * @see <http://www.ecma-international.org/ecma-262/7.0/index.html#sec-runtime-semantics-iswordchar-abstract-operation>
   */
  public static function isWordChar(codepoint:Int):Bool {
    return (0x0061 <= codepoint && codepoint <= 0x007a)
    || (0x0041 <= codepoint && codepoint <= 0x005a)
    || (0x0030 <= codepoint && codepoint <= 0x0039) || codepoint == 0x005f;
  }

  /**
   * - Unicode Character 'LINE FEED (LF)' (U+000A)
   * - Unicode Character 'CARRIAGE RETURN (CR)' (U+000D)
   * - Unicode Character 'LINE SEPARATOR' (U+2028)
   * - Unicode Character 'PARAGRAPH SEPARATOR' (U+2029)
   */
  public static var lineTerminators:Array<Int> = [0x000a, 0x000d, 0x2028, 0x2029];

  /**
   * - Unicode Character 'CHARACTER TABULATION' (U+0009)
   * - Unicode Character 'LINE TABULATION' (U+000B)
   * - Unicode Character 'FORM FEED (FF)' (U+000C)
   * - Unicode Character 'SPACE' (U+0020)
   * - Unicode Character 'NO-BREAK SPACE' (U+00A0)
   * - Unicode Character 'ZERO WIDTH NO-BREAK SPACE' (U+FEFF)
   * TODO:
   * - Any other Unicode character of the "Separator, space" (Zs) general category
   */
  public static var whiteSpaces:Array<Int> = [0x0009, 0x000b, 0x000c, 0x0020, 0x00a0, 0xfeff];

  /**
   * Code points matched by `\s`
   *
   * - Unicode Character 'CHARACTER TABULATION' (U+0009)
   * - Unicode Character 'LINE FEED (LF)' (U+000A)
   * - Unicode Character 'LINE TABULATION' (U+000B)
   * - Unicode Character 'FORM FEED (FF)' (U+000C)
   * - Unicode Character 'CARRIAGE RETURN (CR)' (U+000D)
   * - Unicode Character 'SPACE' (U+0020)
   * - Unicode Character 'NO-BREAK SPACE' (U+00A0)
   * - Unicode Character 'LINE SEPARATOR' (U+2028)
   * - Unicode Character 'PARAGRAPH SEPARATOR' (U+2029)
   * - Unicode Character 'ZERO WIDTH NO-BREAK SPACE' (U+FEFF)
   * TODO:
   * - Any other Unicode character of the "Separator, space" (Zs) general category
   */
  public static var separators:Array<Int> = lineTerminators.concat(whiteSpaces);
}
