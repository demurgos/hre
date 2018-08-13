package hre;

import haxe.ds.Either;
import hre.ast.CharacterClassAtom;
import hre.ast.Alternative;
import hre.ast.Assertion in AssertionNode;
import hre.ast.Atom in AtomNode;
import hre.ast.CharacterClass;
import hre.ast.CharacterClassRange;
import hre.ast.Disjunction;
import hre.ast.Pattern;
import hre.ast.Quantifier;
import hre.ast.Term in TermNode;
import hre.tokens.Symbol;

class RegExpSyntaxError extends HreError {
  public var index(default, null):Int;
  public var source(default, null):String;

  public function new(message:String, index:Int, source:String) {
    super("RegExp syntax error for \"" + source + "\" at index " + index + ": " + message);
    this.index = index;
    this.source = source;
  }
}

/**
 * A quantifier prefix is quantifier without the `greedy` field.
 *
 * `-1` means "unbounded".
 *
 * @internal
 */
class QuantifierPrefix {
  public var min(default, null):Int;
  public var max(default, null):Int;

  public function new(min: Int, max: Int) {
    this.min = min;
    this.max = max;
  }
}

/**
 * Represents an integer literal.
 *
 * Used for decimals (quantifiers) and hex (unicode escapes)
 *
 * @internal
 */
class IntLiteral {
  public var length(default, null):Int;
  public var value(default, null):Int;

  public function new(length: Int, value: Int) {
    this.length = length;
    this.value = value;
  }
}

enum Escape {
  Literal(codepoint:Int);
  Backreference(captureId:Int);
  Word;
  NotWord;
  Decimal;
  NotDecimal;
  Separator;
  NotSeparator;
  WordBoundary;
  NotWordBoundary;
}

class RegExpParser {
  public static function parse(pattern:String):Pattern {
    return new RegExpParser(pattern).readPattern();
  }

  var source:String;
  var currentIndex:Int;
  var length:Int;
  var capturesCount:Int;

  function new(source:String) {
    this.source = source;
    this.currentIndex = 0;
    this.length = source.length;
    this.capturesCount = 0;
  }

  function isEndOfPattern():Bool {
    return switch(this.peek()) {
      case Symbol.EndOfText: true;
      default: false;
    }
  }

  function readPattern():Pattern {
    var alternatives:Array<Alternative> = [];
    while (!this.isEndOfPattern()) {
      alternatives.push(this.readAlternative());
      switch(this.peek()) {
        case Symbol.Character(c):
          switch(c) {
            case "|": this.currentIndex++;
            default: throw new RegExpSyntaxError("Unexpected character " + c, this.currentIndex, this.source);
          }
        case Symbol.EndOfText: break;
      }
    }
    return new Pattern(alternatives, this.capturesCount);
  }

  function isEndOfDisjunction():Bool {
    return switch(this.peek()) {
      case Symbol.EndOfText: true;
      case Symbol.Character(c): c == ")";
    }
  }

  function readDisjunction():Disjunction {
    var alternatives:Array<Alternative> = [];
    while (!this.isEndOfDisjunction()) {
      alternatives.push(this.readAlternative());
      switch(this.peek()) {
        case Symbol.Character(c):
          switch(c) {
            case "|": this.currentIndex++;
            case ")": break;
            default: throw new RegExpSyntaxError("Unexpected character " + c, this.currentIndex, this.source);
          }
        case Symbol.EndOfText: break;
      }
    }
    return new Disjunction(alternatives);
  }

  function isEndOfAlternative():Bool {
    return switch(this.peek()) {
      case Symbol.EndOfText: true;
      case Symbol.Character(c): if (c == "|" || c == ")") {
        return true;
      } else {
        return false;
      };
    }
  }

  function readAlternative():Alternative {
    var terms:Array<TermNode> = [];
    while (!this.isEndOfAlternative()) {
      terms.push(this.readTerm());
    }
    return new Alternative(terms);
  }

  function readTerm():TermNode {
    if (this.readQuantifier() != null) {
      throw new RegExpSyntaxError("There is nothing to repeat", this.currentIndex, this.source);
    }
    var oldCapturesCount:Int = this.capturesCount;

    var assertionOrAtom:Either<AssertionNode, AtomNode> = switch(this.peek()) {
      case Symbol.EndOfText: throw new RegExpSyntaxError("Unexpected end of text", this.currentIndex, this.source);
      case Symbol.Character(c):
        switch(c) {
          case "|": throw new RegExpSyntaxError("Unexpected syntax character |", this.currentIndex, this.source);
          case "^":
            this.currentIndex++; // Consume `^`
            Either.Left(AssertionNode.StartOfText);
          case "$":
            this.currentIndex++; // Consume `$`
            Either.Left(AssertionNode.EndOfText);
          case "\\":
            this.readEscapeTerm();
          case "(":
            this.readGroup();
          case "[":
            Either.Right(this.readCharacterClass());
          case ".":
            this.currentIndex++; // Consume `.`
            Either.Right(AtomNode.AnyCharacter);
          default:
            this.currentIndex++; // Consume c
            Either.Right(AtomNode.Literal(c));
        }
    }

    return switch(assertionOrAtom) {
      case Left(assertion):
        TermNode.Assertion(assertion);
      case Right(atom):
        var quantifier = this.readQuantifier();
        return quantifier == null ? TermNode.Atom(atom) : TermNode.QuantifiedAtom(atom, quantifier, oldCapturesCount, this.capturesCount);
    }
  }

  function readEscape(inCharacterClass:Bool):Escape {
    if (this.peekChar() != "\\") {
      throw new RegExpSyntaxError("Invalid escape term, expected \\", this.currentIndex, this.source);
    }
    this.currentIndex++; // Consume `\`
    return switch(this.peek()) {
      case Symbol.EndOfText: throw new RegExpSyntaxError("Escape at the end of the pattern", this.currentIndex, this.source);
      case Symbol.Character(c):
        var charCode:Int = c.charCodeAt(0);
        if (0x30 <= charCode && charCode <= 0x39) { // isDigit
          if (charCode == 0x30) {
            this.currentIndex++;
            Escape.Literal(0x00);
          } else {
            if (inCharacterClass) {
              throw new RegExpSyntaxError("Invalid decimal escape in character class", this.currentIndex, this.source);
            }
            var decimal:IntLiteral = this.readDecimalDigits();
            var decimalLen:Int = decimal.length;
            var decimalVal:Int = decimal.value;
            Escape.Backreference(decimalVal);
          }
        } else {
          switch(c) {
            case "B":
              if (inCharacterClass) {
                throw new RegExpSyntaxError("Invalid `\\B` escape in character class", this.currentIndex, this.source);
              }
              this.currentIndex++; // Consume `B`
              Escape.NotWordBoundary;
            case "D":
              this.currentIndex++; // Consume `D`
              Escape.NotDecimal;
            case "S":
              this.currentIndex++; // Consume `S`
              Escape.NotSeparator;
            case "W":
              this.currentIndex++; // Consume `W`
              Escape.NotWord;
            case "b":
              this.currentIndex++; // Consume `b`
              if (inCharacterClass) {
                Escape.Literal(0x08);
              } else {
                Escape.WordBoundary;
              }
            case "c":
              this.currentIndex++; // Consume `c`
              var controlLetter:String = this.peekChar();
              var controlLetterCode:Int = controlLetter.charCodeAt(0);
              if (!(0x041 <= controlLetterCode && controlLetterCode <= 0x5a) && !(0x061 <= controlLetterCode && controlLetterCode <= 0x7a)) {
                throw new RegExpSyntaxError("Control letter must be in A-Za-z", this.currentIndex, this.source);
              }
              this.currentIndex++; // Consume controlLetter
              Escape.Literal(controlLetterCode % 32);
            case "d":
              this.currentIndex++; // Consume `d`
              Escape.Decimal;
            case "f":
              this.currentIndex++; // Consume `f`
              Escape.Literal(0x0c);
            case "n":
              this.currentIndex++; // Consume `n`
              Escape.Literal(0x0a);
            case "r":
              this.currentIndex++; // Consume `r`
              Escape.Literal(0x0d);
            case "s":
              this.currentIndex++; // Consume `s`
              Escape.Separator;
            case "t":
              this.currentIndex++; // Consume `t`
              Escape.Literal(0x09);
            case "u":
              this.currentIndex++; // Consume `u`
              var codePoint = if (this.peekChar() == "{") {
                this.currentIndex++; // Consume `{`
                var hexLiteral:IntLiteral = this.readHexadecimal(4, -1);
                if (this.peekChar() != "}") {
                  throw new RegExpSyntaxError("Expected `}`", this.currentIndex, this.source);
                }
                this.currentIndex++; // Consume `}`
                hexLiteral.value;
              } else {
                this.readHexadecimal(4, 4).value;
              }
              if (codePoint > 0x10ffff) {
                throw new RegExpSyntaxError("Codepoint exceeds max value (0x10ffff)`", this.currentIndex, this.source);
              }
              Escape.Literal(codePoint);
            case "v":
              this.currentIndex++; // Consume `v`
              Escape.Literal(0x0b);
            case "w":
              this.currentIndex++; // Consume `w`
              Escape.Word;
            case "x":
              this.currentIndex++; // Consume `x`
              var hexLiteral:IntLiteral = this.readHexadecimal(2, 2);
              Escape.Literal(hexLiteral.value);
            default:
              this.currentIndex++; // Consume c
              // TODO: reject unicode code points with the "Other_ID_Continue" unicode property
              Escape.Literal(c.charCodeAt(0));
          }
        }
    }
  }

  function readEscapeTerm():Either<AssertionNode, AtomNode> {
    return switch(this.readEscape(false)) {
      case Escape.Literal(codePoint):
        Either.Right(AtomNode.Literal(String.fromCharCode(codePoint)));
      case Escape.Backreference(captureId):
        Either.Right(AtomNode.Backreference(captureId));
      case Escape.Decimal:
        Either.Right(AtomNode.Decimal);
      case Escape.NotDecimal:
        Either.Right(AtomNode.NotDecimal);
      case Escape.Separator:
        Either.Right(AtomNode.Separator);
      case Escape.NotSeparator:
        Either.Right(AtomNode.NotSeparator);
      case Escape.Word:
        Either.Right(AtomNode.Word);
      case Escape.NotWord:
        Either.Right(AtomNode.NotWord);
      case Escape.WordBoundary:
        Either.Left(AssertionNode.WordBoundary);
      case Escape.NotWordBoundary:
        Either.Left(AssertionNode.NotWordBoundary);
    }
  }

  function readGroup():Either<AssertionNode, AtomNode> {
    if (this.peekChar() != "(") {
      throw new RegExpSyntaxError("Invalid group, expected (", this.currentIndex, this.source);
    }
    this.currentIndex++; // consume `(`
    var kind:GroupKind = GroupKind.Capture;
    var oldCaptureCount = this.capturesCount;
    switch(this.peek()) {
      case Symbol.EndOfText: throw new RegExpSyntaxError("Unterminated group", this.currentIndex, this.source);
      case Symbol.Character(c):
        // Group has a modifier
        if (c == "?") {
          this.currentIndex++; // consume `?`
          switch(this.peek()) {
            case Symbol.EndOfText: throw new RegExpSyntaxError("Invalid group, expected modifier", this.currentIndex, this.source);
            case Symbol.Character(c):
              kind = switch (c) {
                case "=": GroupKind.FollowedBy;
                case "!": GroupKind.NotFollowedBy;
                case ":": GroupKind.Simple;
                default: throw new RegExpSyntaxError("Invalid group, unknown modifier: " + c, this.currentIndex, this.source);
              }
          }
          this.currentIndex++; // Consume the modifier
        }
    }

    switch(kind){
      case GroupKind.Capture:
        this.capturesCount++;
      default: {};
    }

    var disjunction:Disjunction = this.readDisjunction();
    switch(this.peek()) {
      case Symbol.EndOfText: throw new RegExpSyntaxError("Invalid group, unterminated group", this.currentIndex, this.source);
      case Symbol.Character(c):
        switch (c) {
          case ")": this.currentIndex++;
          default: "Invalid group, expected )";
        }
    }
    return switch(kind) {
      case GroupKind.Capture:
        Either.Right(AtomNode.CaptureGroup(disjunction, oldCaptureCount));
      case GroupKind.Simple:
        Either.Right(AtomNode.SimpleGroup(disjunction));
      case GroupKind.FollowedBy: Either.Left(AssertionNode.FollowedBy(disjunction));
      case GroupKind.NotFollowedBy: Either.Left(AssertionNode.NotFollowedBy(disjunction));
    }
  }

  function isEndOfCharacterClass():Bool {
    return switch(this.peek()) {
      case Symbol.EndOfText: false;
      case Symbol.Character(c): c == "]";
    }
  }

  function readCharacterClass():AtomNode {
    if (this.peekChar() != "[") {
      throw new RegExpSyntaxError("Invalid character class, expected [", this.currentIndex, this.source);
    }
    this.currentIndex++; // consume `[`
    var inverted:Bool = switch(this.peek()) {
      case Symbol.EndOfText: throw new RegExpSyntaxError("Unterminated character class", this.currentIndex, this.source);
      case Symbol.Character(c):
        if (c == "^") {
          this.currentIndex++; // Consume `^`
          true;
        } else {
          false;
        }
    }
    var ranges:Array<CharacterClassRange> = [];
    while (!this.isEndOfCharacterClass()) {
      ranges.push(this.readCharacterClassRange(ranges.length == 0));
    }
    switch(this.peek()) {
      case Symbol.EndOfText: throw new RegExpSyntaxError("Unterminated character class", this.currentIndex, this.source);
      case Symbol.Character(c):
        switch (c) {
          case "]": this.currentIndex++;
          default: "Invalid character class, expected ]";
        }
    }
    return AtomNode.Class(new CharacterClass(inverted, ranges));
  }

  function readCharacterClassRange(firstRange:Bool):CharacterClassRange {
    var start = this.readCharacterClassAtom(!firstRange);
    if (start == null) {
      throw new RegExpSyntaxError("Expected character class atom", this.currentIndex, this.source);
    }
    var c = this.peekChar();
    if (c != "-") {
      return CharacterClassRange.Simple(start);
    }
    // If `-` is at the end of the character class it is a literal, otherwise it marks a range.
    // This seems to be the only place when we really need to check two characters in advance
    if (this.peekChar(1) == "]") {
      return CharacterClassRange.Simple(start);
    }
    this.currentIndex++; // Consume `-`
    var end = this.readCharacterClassAtom(false);
    if (end == null) {
      throw new RegExpSyntaxError("Invalid range in character class", this.currentIndex, this.source);
    }

    var startCharacter:String = switch (start) {
      case CharacterClassAtom.Literal(c): c;
      default: throw new RegExpSyntaxError("Start of range is not a literal", this.currentIndex, this.source);
    }
    var endCharacter:String = switch (end) {
      case CharacterClassAtom.Literal(c): c;
      default: throw new RegExpSyntaxError("End of range is not a literal", this.currentIndex, this.source);
    }
    if (startCharacter.charCodeAt(0) > endCharacter.charCodeAt(0)) {
      throw new RegExpSyntaxError("Invalid range", this.currentIndex, this.source);
    }
    return CharacterClassRange.Range(startCharacter, endCharacter);
  }

  function readCharacterClassAtom(noDash:Bool):CharacterClassAtom {
    switch(this.peek()) {
      case Symbol.EndOfText: return null;
      case Symbol.Character(c):
        switch (c) {
          case "]":
            return null;
          case "\\":
            return this.readEscapedCharacterClassAtom();
          case "-":
            if (noDash) {
              return null;
            }
            this.currentIndex++; // Consume `-`
            return CharacterClassAtom.Literal("-");
          default:
            this.currentIndex++; // Consume c
            return CharacterClassAtom.Literal(c);
        }
    }
  }

  function readEscapedCharacterClassAtom():CharacterClassAtom {
    var escape:Escape = this.readEscape(true);
    return switch(escape) {
      case Escape.Literal(codePoint):
        CharacterClassAtom.Literal(String.fromCharCode(codePoint));
      case Escape.Decimal:
        CharacterClassAtom.Decimal;
      case Escape.NotDecimal:
        CharacterClassAtom.NotDecimal;
      case Escape.Separator:
        CharacterClassAtom.Separator;
      case Escape.NotSeparator:
        CharacterClassAtom.NotSeparator;
      case Escape.Word:
        CharacterClassAtom.Word;
      case Escape.NotWord:
        CharacterClassAtom.NotWord;
      default:
        throw new RegExpSyntaxError("Unexpected escape in character class: " + Type.enumConstructor(escape), this.currentIndex, this.source);
    }
  }

  function isGreedyQuantifier():Bool {
    return switch(this.peek()) {
      case Symbol.Character(c): c != "?";
      default: true;
    }
  }

  /**
   * Tries to read a quantifier prefix such as "*", "+", "?", "{2}", "{2,}" or "{2,4}".
   * If it succeeds, it returns a QuantifierPrefix(min, max) and moves the current index. If max is -1 it
   * means that there is no upper bound.
   * If it fails to match, it returns null and does not move the current index.
   */
  function readQuantifierPrefix():QuantifierPrefix {
    return switch(this.peek()) {
      case Symbol.Character(c):
        switch(c) {
          case "*": this.currentIndex++; new QuantifierPrefix(0, -1);
          case "+": this.currentIndex++; new QuantifierPrefix(1, -1);
          case "?": this.currentIndex++; new QuantifierPrefix(0, 1);
          case "{": this.readQuantifierBlock();
          default: null;
        }
      default: null;
    }
  }

  /**
   * Tries to read a quantifier block such as "{2}", "{2,}" or "{2,4}".
   * If it succeeds, it returns a QuantifierPrefix(min, max) and moves the current index. If max is -1 it
   * means that there is no upper bound.
   * If it fails to match, it returns null and does not move the current index.
   */
  function readQuantifierBlock():QuantifierPrefix {
    // TODO: do not backtrack but raise a syntax error
    var oldIndex = this.currentIndex; // We might backtrack in case of invalid block
    if (this.peekChar() != "{") {
      return null;
    }
    this.currentIndex++; // Consume `{`
    var min:IntLiteral = this.readDecimalDigits();
    var minLen:Int = min.length;
    var minVal:Int = min.value;
    if (minLen == 0) {
      this.currentIndex = oldIndex; // Backtrack. Example: "a{"
      return null;
    }

    switch(this.peek()) {
      case Symbol.EndOfText:
        this.currentIndex = oldIndex; // Backtrack. Example: "a{1"
        return null;
      case Symbol.Character(c):
        switch(c) {
          case "}":
            this.currentIndex++; // Consume `}`
            return new QuantifierPrefix(minVal, minVal); // Example: "a{2}"
          case ",": // Has a maximum
            this.currentIndex++; // Consume `,`
          default:
            this.currentIndex = oldIndex; // Backtrack. Example "a{2,"
            return null;
        }
    }
    var max:IntLiteral = this.readDecimalDigits();
    var maxLen:Int = max.length;
    var maxVal:Int = max.value;
    return switch(this.peek()) {
      case Symbol.EndOfText:
        this.currentIndex = oldIndex; // Backtrack. Example: "a{2,", "a{2,3"
        null;
      case Symbol.Character(c):
        if (c != "}") {
          this.currentIndex = oldIndex; // Backtrack. Example: "a{2,3b"
          return null;
        }
        this.currentIndex++; // Consume `}`
        if (maxLen == 0) {
          new QuantifierPrefix(minVal, -1);
        } else {
          if (maxVal < minVal) { // TODO: move this to the matcher ?
            throw new RegExpSyntaxError("Max is finite and less than min", this.currentIndex, this.source);
          }
          new QuantifierPrefix(minVal, maxVal);
        }
    }
  }

  /**
   * Reads the next quantifier or returns null if there is no quantifier.
   * If it fails to match a quantifier, the current index is not moved.
   */
  function readQuantifier():Quantifier {
    var prefix:QuantifierPrefix = this.readQuantifierPrefix();
    if (prefix == null) {
      return null;
    }
    var greedy:Bool = this.isGreedyQuantifier();
    if (!greedy) {
      this.currentIndex++; // Consume `?`
    }
    return new Quantifier(prefix.min, prefix.max, greedy);
  }

  /**
   * While there are digits, reads the source and computes the value.
   * It returns an IntLiteral(length, value).
   * `length` is the number of consumed digits, it can be 0. The current index is moved by `length`.
   * `value` is the decimal value of the digits.
   */
  function readDecimalDigits():IntLiteral {
    var len = 0;
    var val = 0;

    while (true) {
      switch(this.peek()) {
        case Symbol.Character(c):
          var charCode:Int = c.charCodeAt(0);
          // The code points for the digits are 0x30-0x39 (inclusive)
          if (0x30 <= charCode && charCode <= 0x39) {
            this.currentIndex++;
            len++;
            val = 10 * val + (charCode - 0x30);
          } else {
            break;
          }
        default: break;
      };
    }
    return new IntLiteral(len, val);
  }

  /**
   * Read between minLen (inclusive) and maxLen (inclusive) hexadecimal digits (0-9a-fA-F) and
   * returns an IntLiteral(len, value).
   * Set maxLen to `-1` for Infinity.
   */
  function readHexadecimal(minLen:Int, maxLen:Int):IntLiteral {
    var len = 0;
    var val = 0;

    while (true) {
      if (maxLen == -1 && len >= maxLen) {
        break;
      }
      switch(this.peek()) {
        case Symbol.Character(c):
          var charCode:Int = c.charCodeAt(0);
          if (0x30 <= charCode && charCode <= 0x39) { // 0-9
            this.currentIndex++;
            len++;
            val = 16 * val + (charCode - 0x30);
          } else if (0x41 <= charCode && charCode <= 0x46) { // A-F
            this.currentIndex++;
            len++;
            val = 16 * val + (10 + charCode - 0x41);
          } else if (0x61 <= charCode && charCode <= 0x66) { // a-f
            this.currentIndex++;
            len++;
            val = 16 * val + (10 + charCode - 0x61);
          } else {
            break;
          }
        default: break;
      };
    }
    if (len < minLen) {
      throw new RegExpSyntaxError("Not enough hex digits", this.currentIndex, this.source);
    }
    return new IntLiteral(len, val);
  }

  function symbolAt(index:Int):Symbol {
    return index < this.length ? Symbol.Character(this.source.charAt(index)) : Symbol.EndOfText;
  }

  function charAt(index:Int):String {
    if (index >= this.length) {
      throw new RegExpSyntaxError("Unexpected end of text", this.currentIndex, this.source);
    }
    return this.source.charAt(index);
  }

  function peek(lookahead:Int = 0):Symbol {
    return this.symbolAt(this.currentIndex + lookahead);
  }

  function peekChar(lookahead:Int = 0):String {
    return this.charAt(this.currentIndex + lookahead);
  }
}

enum GroupKind {
  Capture;
  Simple;
  FollowedBy;
  NotFollowedBy;
}
