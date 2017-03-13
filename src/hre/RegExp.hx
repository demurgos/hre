package hre;

import hre.RegExpParser.RegExpSyntaxError;
import hre.RegExpMatcher.PatternMatcher;
import hre.RegExpMatcher.MatcherResult;
import hre.RegExpMatcher.MatcherState;
import hre.ast.Pattern;

/**
 * PuRE is a Pure Haxe Regular Expression implementation based on the ES7 specification (itself inspired by Perl 5):
 * http://www.ecma-international.org/ecma-262/7.0/index.html#sec-patterns
 */
class RegExp {
  public var length:Int = 2;
  public var lastIndex:Int;

  private var pattern:Pattern;
  private var flags:RegExpFlags;
  // public var source:Bool; // pattern.toString()

  /**
   * The `RegExp` constructor creates a regular expression object for matching text with a pattern.
   *
   * @param pattern The text of the regular expression.
   */
  public function new(pattern:String, ?flags:String) {
    this.pattern = RegExpParser.parse(pattern);
    var global = false;
    var ignoreCase = false;
    var multiline = false;
    var sticky = false;

    if (flags != null) {
      for (i in 0...flags.length) {
        switch (flags.charAt(i)) {
          case "g":
            global = true;
          case "i":
            ignoreCase = true;
          case "m":
            multiline = true;
          case "u":
            trace("Unicode flag is always enabled, no need to provide it");
          case "y":
            sticky = true;
          default:
            throw new RegExpSyntaxError("Invalid flags", 0, pattern);
        }
      }
    }
    this.flags = new RegExpFlags(global, ignoreCase, multiline, sticky);
    this.lastIndex = 0;
  }

  public function exec(input:String):Match {
    var matcher:PatternMatcher = RegExpMatcher.evaluatePattern(this.pattern, this.flags);
    var currentIndex:Int = this.flags.global || this.flags.sticky ? this.lastIndex : 0;
    var successfulMatch:MatcherState;
    while (true) {
      if (currentIndex > input.length) {
        this.lastIndex = 0;
        return null;
      }
      switch(matcher(input, currentIndex)) {
        case MatcherResult.Failure: {
          if (this.flags.sticky) {
            this.lastIndex = 0;
            return null;
          }
          currentIndex++;
          continue;
        }
        case MatcherResult.Success(state): {
          successfulMatch = state;
          break;
        }
      }
    }
    if (this.flags.global || this.flags.sticky) {
      this.lastIndex = successfulMatch.index;
    }
    var matchedSubstring:String = input.substring(currentIndex, successfulMatch.index);
    var groups:Array<String> = [matchedSubstring];
    for (captured in successfulMatch.captures) {
      groups.push(captured);
    }
    return new Match(input, currentIndex, groups);
  }

  public function test(input:String):Bool {
    return this.exec(input) != null;
  }
}
