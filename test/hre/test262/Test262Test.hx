package hre.test262;

import haxe.PosInfos;
import massive.munit.Assert;
import massive.munit.AssertionException;
import hre.RegExpParser.RegExpSyntaxError;

class Test262Test {
  /**
   * Assert that two `Match` instances are equivalent.
   *
   * @param expected Expected match
	 * @param actual Actual match
	 * @throws AssertionException	If expected is not equal to the actual value
   */
  public static function assertAreEqualMatches(expected:Match, actual:Match, ?info:PosInfos):Void {
    if (!expected.equals(actual)) {
      throw new AssertionException("Value [" + actual + "] was not equal to expected value [" + expected + "]", info);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/15.10.2.15-6-1.js>
   */
  @Test
  public function _15_10_2_15_6_1() {
    AssertPattern.throwsSyntaxError("^[z-a]$");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/15.10.2.5-3-1.js>
   */
  @Test
  public function _15_10_2_5_3_1() {
    AssertPattern.throwsSyntaxError("0{2,1}");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/15.10.4.1-1.js>
   */
  @Ignore("Building RegExp from other RegExp is not planned")
  @Test
  public function _15_10_4_1_1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/15.10.4.1-2.js>
   */
  @Test
  public function _15_10_4_1_2() {
    AssertPattern.throwsSyntaxError("\\");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/15.10.4.1-3.js>
   */
  @Test
  public function _15_10_4_1_3() {
    try {
      var re = new RegExp("abc", "a");
      Assert.fail("Expected error, invalid flag");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/15.10.4.1-4.js>
   */
  @Test
  public function _15_10_4_1_4() {
    // Simply do not throw an errow
    var re = new RegExp("abc", "gim");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T1.js>
   */
  @Test
  public function S15_10_1_A1_T1() {
    try {
      var re = new RegExp("a**");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T2.js>
   */
  @Test
  public function S15_10_1_A1_T2() {
    try {
      var re = new RegExp("a***");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T3.js>
   */
  @Test
  public function S15_10_1_A1_T3() {
    try {
      var re = new RegExp("a++");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T4.js>
   */
  @Test
  public function S15_10_1_A1_T4() {
    try {
      var re = new RegExp("a+++");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T5.js>
   */
  @Test
  public function S15_10_1_A1_T5() {
    try {
      var re = new RegExp("a???");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T6.js>
   */
  @Test
  public function S15_10_1_A1_T6() {
    try {
      var re = new RegExp("a????");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T7.js>
   */
  @Test
  public function S15_10_1_A1_T7() {
    try {
      var re = new RegExp("*a");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T8.js>
   */
  @Test
  public function S15_10_1_A1_T8() {
    try {
      var re = new RegExp("**a");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T9.js>
   */
  @Test
  public function S15_10_1_A1_T9() {
    try {
      var re = new RegExp("+a");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T10.js>
   */
  @Test
  public function S15_10_1_A1_T10() {
    try {
      var re = new RegExp("++a");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T11.js>
   */
  @Test
  public function S15_10_1_A1_T11() {
    try {
      var re = new RegExp("?a");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T12.js>
   */
  @Test
  public function S15_10_1_A1_T12() {
    try {
      var re = new RegExp("??a");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T13.js>
   */
  @Test
  public function S15_10_1_A1_T13() {
    try {
      var re = new RegExp("x{1}{1,}");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T14.js>
   */
  @Test
  public function S15_10_1_A1_T14() {
    try {
      var re = new RegExp("x{1,2}{1}");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T15.js>
   */
  @Test
  public function S15_10_1_A1_T15() {
    try {
      var re = new RegExp("x{1,}{1}");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.1_A1_T16.js>
   */
  @Test
  public function S15_10_1_A1_T16() {
    try {
      var re = new RegExp("x{0,1}{1,}");
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A1.1_T1.js>
   */
  @Test
  public function S15_10_2_10_A1_1_T1() {
    {
      var patternSource = "\\t";
      var input = "\u0009";
      var expectedMatch:Match = new Match(input, 0, ["\u0009"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\t\\t";
      var input = "\u0009\u0009b";
      var expectedMatch:Match = new Match(input, 0, ["\u0009\u0009"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A1.2_T1.js>
   */
  @Test
  public function S15_10_2_10_A1_2_T1() {
    {
      var patternSource = "\\n";
      var input = "\u000a";
      var expectedMatch:Match = new Match(input, 0, ["\u000a"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\n\\n";
      var input = "\u000a\u000ab";
      var expectedMatch:Match = new Match(input, 0, ["\u000a\u000a"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A1.3_T1.js>
   */
  @Test
  public function S15_10_2_10_A1_3_T1() {
    {
      var patternSource = "\\v";
      var input = "\u000b";
      var expectedMatch:Match = new Match(input, 0, ["\u000b"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\v\\v";
      var input = "\u000b\u000bb";
      var expectedMatch:Match = new Match(input, 0, ["\u000b\u000b"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A1.4_T1.js>
   */
  @Test
  public function S15_10_2_10_A1_4_T1() {
    {
      var patternSource = "\\f";
      var input = "\u000c";
      var expectedMatch:Match = new Match(input, 0, ["\u000c"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\f\\f";
      var input = "\u000c\u000cb";
      var expectedMatch:Match = new Match(input, 0, ["\u000c\u000c"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A1.5_T1.js>
   */
  @Test
  public function S15_10_2_10_A1_5_T1() {
    {
      var patternSource = "\\r";
      var input = "\u000d";
      var expectedMatch:Match = new Match(input, 0, ["\u000d"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\r\\r";
      var input = "\u000d\u000db";
      var expectedMatch:Match = new Match(input, 0, ["\u000d\u000d"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A2.1_T1.js>
   */
  @Test
  public function S15_10_2_10_A2_1_T1() {
    for (alpha in 0x0041...0x005a + 1) {
      var patternSource = "\\c" + String.fromCharCode(alpha);
      var input = String.fromCharCode(alpha % 32);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A2.1_T2.js>
   */
  @Test
  public function S15_10_2_10_A2_1_T2() {
    for (alpha in 0x0061...0x007a + 1) {
      var patternSource = "\\c" + String.fromCharCode(alpha);
      var input = String.fromCharCode(alpha % 32);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A3.1_T1.js>
   */
  @Test
  public function S15_10_2_10_A3_1_T1() {
    {
      var patternSource = "\\x00";
      var input = "\u0000";
      var expectedMatch:Match = new Match("\u0000", 0, ["\u0000"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\x01";
      var input = "\u0001";
      var expectedMatch:Match = new Match("\u0001", 0, ["\u0001"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\x0a";
      var input = "\u000a";
      var expectedMatch:Match = new Match("\u000a", 0, ["\u000a"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var patternSource = "\\xff";
      var input = "\u00ff";
      var expectedMatch:Match = new Match("\u00ff", 0, ["\u00ff"]);
      var actualMatch:Match = new RegExp(patternSource).exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A3.1_T2.js>
   */
  @Test
  public function S15_10_2_10_A3_1_T2() {
    {
      // English capital alphabet
      var patterns:Array<String> = ["\\x41", "\\x42", "\\x43", "\\x44", "\\x45", "\\x46", "\\x47", "\\x48", "\\x49", "\\x4A", "\\x4B", "\\x4C", "\\x4D", "\\x4E", "\\x4F", "\\x50", "\\x51", "\\x52", "\\x53", "\\x54", "\\x55", "\\x56", "\\x57", "\\x58", "\\x59", "\\x5A"];
      var inputs:Array<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
      Assert.areEqual(26, patterns.length);
      Assert.areEqual(26, inputs.length);
      for (i in 0...26) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
    {
      // English small alphabet
      var patterns:Array<String> = ["\\x61", "\\x62", "\\x63", "\\x64", "\\x65", "\\x66", "\\x67", "\\x68", "\\x69", "\\x6A", "\\x6B", "\\x6C", "\\x6D", "\\x6E", "\\x6F", "\\x70", "\\x71", "\\x72", "\\x73", "\\x74", "\\x75", "\\x76", "\\x77", "\\x78", "\\x79", "\\x7A"];
      var inputs:Array<String> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
      Assert.areEqual(26, patterns.length);
      Assert.areEqual(26, inputs.length);
      for (i in 0...26) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
  }

  /**
   * Custom extension of S15_10_2_10_A3_1_T2_bis to check hexadecimal with minuscules
   */
  @Test
  public function S15_10_2_10_A3_1_T2_bis() {
    {
      // English capital alphabet
      var patterns:Array<String> = ["\\x41", "\\x42", "\\x43", "\\x44", "\\x45", "\\x46", "\\x47", "\\x48", "\\x49", "\\x4a", "\\x4b", "\\x4c", "\\x4d", "\\x4e", "\\x4f", "\\x50", "\\x51", "\\x52", "\\x53", "\\x54", "\\x55", "\\x56", "\\x57", "\\x58", "\\x59", "\\x5a"];
      var inputs:Array<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
      Assert.areEqual(26, patterns.length);
      Assert.areEqual(26, inputs.length);
      for (i in 0...26) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
    {
      // English small alphabet
      var patterns:Array<String> = ["\\x61", "\\x62", "\\x63", "\\x64", "\\x65", "\\x66", "\\x67", "\\x68", "\\x69", "\\x6a", "\\x6b", "\\x6c", "\\x6d", "\\x6e", "\\x6f", "\\x70", "\\x71", "\\x72", "\\x73", "\\x74", "\\x75", "\\x76", "\\x77", "\\x78", "\\x79", "\\x7a"];
      var inputs:Array<String> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
      Assert.areEqual(26, patterns.length);
      Assert.areEqual(26, inputs.length);
      for (i in 0...26) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A4.1_T1.js>
   */
  @Test
  public function S15_10_2_10_A4_1_T1() {
    {
      var expectedMatch:Match = new Match("\u0000", 0, ["\u0000"]);
      var actualMatch:Match = new RegExp("\\u0000").exec("\u0000");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u0001", 0, ["\u0001"]);
      var actualMatch:Match = new RegExp("\\u0001").exec("\u0001");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u000a", 0, ["\u000a"]);
      var actualMatch:Match = new RegExp("\\u000a").exec("\u000a");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u00ff", 0, ["\u00ff"]);
      var actualMatch:Match = new RegExp("\\u00ff").exec("\u00ff");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u0fff", 0, ["\u0fff"]);
      var actualMatch:Match = new RegExp("\\u0fff").exec("\u0fff");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\uffff", 0, ["\uffff"]);
      var actualMatch:Match = new RegExp("\\uffff").exec("\uffff");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A4.1_T2.js>
   */
  @Test
  public function S15_10_2_10_A4_1_T2() {
    {
      // English capital alphabet
      var patterns:Array<String> = ["\\u0041", "\\u0042", "\\u0043", "\\u0044", "\\u0045", "\\u0046", "\\u0047", "\\u0048", "\\u0049", "\\u004a", "\\u004b", "\\u004c", "\\u004d", "\\u004e", "\\u004f", "\\u0050", "\\u0051", "\\u0052", "\\u0053", "\\u0054", "\\u0055", "\\u0056", "\\u0057", "\\u0058", "\\u0059", "\\u005a"];
      var inputs:Array<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
      Assert.areEqual(26, patterns.length);
      Assert.areEqual(26, inputs.length);
      for (i in 0...26) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
    {
      // English small alphabet
      var patterns:Array<String> = ["\\u0061", "\\u0062", "\\u0063", "\\u0064", "\\u0065", "\\u0066", "\\u0067", "\\u0068", "\\u0069", "\\u006a", "\\u006b", "\\u006c", "\\u006d", "\\u006e", "\\u006f", "\\u0070", "\\u0071", "\\u0072", "\\u0073", "\\u0074", "\\u0075", "\\u0076", "\\u0077", "\\u0078", "\\u0079", "\\u007a"];
      var inputs:Array<String> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
      Assert.areEqual(26, patterns.length);
      Assert.areEqual(26, inputs.length);
      for (i in 0...26) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A4.1_T3.js>
   */
  @Test
  public function S15_10_2_10_A4_1_T3() {
    {
      // Russian capital alphabet
      var patterns:Array<String> = ["\\u0410", "\\u0411", "\\u0412", "\\u0413", "\\u0414", "\\u0415", "\\u0416", "\\u0417", "\\u0418", "\\u0419", "\\u041A", "\\u041B", "\\u041C", "\\u041D", "\\u041E", "\\u041F", "\\u0420", "\\u0421", "\\u0422", "\\u0423", "\\u0424", "\\u0425", "\\u0426", "\\u0427", "\\u0428", "\\u0429", "\\u042A", "\\u042B", "\\u042C", "\\u042D", "\\u042E", "\\u042F", "\\u0401"];
      var inputs:Array<String> = ["\u0410", "\u0411", "\u0412", "\u0413", "\u0414", "\u0415", "\u0416", "\u0417", "\u0418", "\u0419", "\u041A", "\u041B", "\u041C", "\u041D", "\u041E", "\u041F", "\u0420", "\u0421", "\u0422", "\u0423", "\u0424", "\u0425", "\u0426", "\u0427", "\u0428", "\u0429", "\u042A", "\u042B", "\u042C", "\u042D", "\u042E", "\u042F", "\u0401"];
      Assert.areEqual(33, patterns.length);
      Assert.areEqual(33, inputs.length);
      for (i in 0...33) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
    {
      // Russian small alphabet
      var patterns:Array<String> = ["\\u0430", "\\u0431", "\\u0432", "\\u0433", "\\u0434", "\\u0435", "\\u0436", "\\u0437", "\\u0438", "\\u0439", "\\u043A", "\\u043B", "\\u043C", "\\u043D", "\\u043E", "\\u043F", "\\u0440", "\\u0441", "\\u0442", "\\u0443", "\\u0444", "\\u0445", "\\u0446", "\\u0447", "\\u0448", "\\u0449", "\\u044A", "\\u044B", "\\u044C", "\\u044D", "\\u044E", "\\u044F", "\\u0451"];
      var inputs:Array<String> = ["\u0430", "\u0431", "\u0432", "\u0433", "\u0434", "\u0435", "\u0436", "\u0437", "\u0438", "\u0439", "\u043A", "\u043B", "\u043C", "\u043D", "\u043E", "\u043F", "\u0440", "\u0441", "\u0442", "\u0443", "\u0444", "\u0445", "\u0446", "\u0447", "\u0448", "\u0449", "\u044A", "\u044B", "\u044C", "\u044D", "\u044E", "\u044F", "\u0451"];
      Assert.areEqual(33, patterns.length);
      Assert.areEqual(33, inputs.length);
      for (i in 0...33) {
        var pattern = patterns[i];
        var input = inputs[i];
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = new RegExp(pattern).exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.10_A5.1_T1.js>
   */
  @Test
  public function S15_10_2_10_A5_1_T1() {
    var nonIdent = "~`!@#$%^&*()-+={[}]|\\:;'<,>./?\"";
    for (k in 0...nonIdent.length) {
      var patternSource = "\\" + nonIdent.charAt(k);
      var expectedMatch:Match = new Match(nonIdent, k, [nonIdent.charAt(k)]);
      var actualMatch:Match = new RegExp(patternSource, "g").exec(nonIdent);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T1.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T1() {
    var expectedMatch:Match = new Match("\u0000", 0, ["\u0000"]);
    var actualMatch:Match = new RegExp("\\0").exec("\u0000");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  // There is no S15_10_2_11_A1_1_T2
  // There is no S15_10_2_11_A1_1_T3

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T4.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T4() {
    var expectedMatch:Match = new Match("AA", 0, ["AA", "A"]);
    var actualMatch:Match = new RegExp("(A)\\1").exec("AA");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T5.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T5() {
    var expectedMatch:Match = new Match("AA", 0, ["A", "A"]);
    var actualMatch:Match = new RegExp("\\1(A)").exec("AA");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T6.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T6() {
    var expectedMatch:Match = new Match("AABB", 0, ["AABB", "A", "B"]);
    var actualMatch:Match = new RegExp("(A)\\1(B)\\2").exec("AABB");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T7.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T7() {
    var expectedMatch:Match = new Match("ABB", 0, ["ABB", "A", "B"]);
    var actualMatch:Match = new RegExp("\\1(A)(B)\\2").exec("ABB");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T8.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T8() {
    var expectedMatch:Match = new Match("AAAAAAAAAAA", 0, ["AAAAAAAAAAA", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A"]);
    var actualMatch:Match = new RegExp("((((((((((A))))))))))\\1\\2\\3\\4\\5\\6\\7\\8\\9\\10").exec("AAAAAAAAAAA");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.11_A1_T9.js>
   */
  @Test
  public function S15_10_2_11_A1_1_T9() {
    var expectedMatch:Match = new Match("AAAAAAAAAAA", 0, ["AAAAAAAAAAA", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A"]);
    var actualMatch:Match = new RegExp("((((((((((A))))))))))\\10\\9\\8\\7\\6\\5\\4\\3\\2\\1").exec("AAAAAAAAAAA");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A1_T1.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_12_A1_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A1_T2.js>
   */
  @Test
  public function S15_10_2_12_A1_T2() {
    {
      var expectedMatch:Match = new Match("\u000a", 0, ["\u000a"]);
      var actualMatch:Match = new RegExp("\\s").exec("\u000a");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u000d", 0, ["\u000d"]);
      var actualMatch:Match = new RegExp("\\s").exec("\u000d");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u2028", 0, ["\u2028"]);
      var actualMatch:Match = new RegExp("\\s").exec("\u2028");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      var expectedMatch:Match = new Match("\u2029", 0, ["\u2029"]);
      var actualMatch:Match = new RegExp("\\s").exec("\u2029");
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A1_T3.js>
   */
  @Test
  public function S15_10_2_12_A1_T3() {
    var regExp = new RegExp("\\s");
    // English capital alphabet
    for (alpha in 0x0041...0x005a + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
    // English small alphabet
    for (alpha in 0x0061...0x007a + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A1_T4.js>
   */
  @Test
  public function S15_10_2_12_A1_T4() {
    var regExp = new RegExp("\\s");
    // Russian capital alphabet
    for (alpha in 0x0410...0x042F + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
    // Russian small alphabet
    for (alpha in 0x0430...0x044F + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A1_T5.js>
   */
  @Test
  public function S15_10_2_12_A1_T5() {
    {
      var nonSeparators = "0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~`!@#$%^&*()-+={[}]|\\:;'<,>./?\"";
      Assert.isNull(new RegExp("\\s").exec(nonSeparators));
    }
    {
      var regExp = new RegExp("\\s", "g");
      var separators = "\x0c\n\r\t\x0b ";
      var loopLimit = 100;
      var loopCount = 0;
      var k = 0;
      while (regExp.exec(separators) != null) {
        loopCount++;
        if (loopCount >= loopLimit) {
          Assert.fail("Infinite loop");
        }
        k++;
      }
      Assert.areEqual(separators.length, k);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A2_T1.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_12_A2_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A2_T2.js>
   */
  @Test
  public function S15_10_2_12_A2_T2() {
    {
      var actualMatch:Match = new RegExp("\\S").exec("\u000a");
      Assert.isNull(actualMatch);
    }
    {
      var actualMatch:Match = new RegExp("\\S").exec("\u000d");
      Assert.isNull(actualMatch);
    }
    {
      var actualMatch:Match = new RegExp("\\S").exec("\u000a");
      Assert.isNull(actualMatch);
    }
    {
      var actualMatch:Match = new RegExp("\\S").exec("\u2029");
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A2_T3.js>
   */
  @Test
  public function S15_10_2_12_A2_T3() {
    var regExp = new RegExp("\\S");
    // English capital alphabet
    for (alpha in 0x0041...0x005a + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    // English small alphabet
    for (alpha in 0x0061...0x007a + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A2_T4.js>
   */
  @Test
  public function S15_10_2_12_A2_T4() {
    var regExp = new RegExp("\\S");
    // Russian capital alphabet
    for (alpha in 0x0410...0x042f + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    // Russian small alphabet
    for (alpha in 0x0430...0x044f + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A2_T5.js>
   */
  @Test
  public function S15_10_2_12_A2_T5() {
    {
      var regExp = new RegExp("\\S", "g");
      var nonSeparators = "0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~`!@#$%^&*()-+={[}]|\\:;'<,>./?\"";
      var loopLimit = 200;
      var loopCount = 0;
      var k = 0;
      while (regExp.exec(nonSeparators) != null) {
        loopCount++;
        if (loopCount >= loopLimit) {
          Assert.fail("Infinite loop");
        }
        k++;
      }
      Assert.areEqual(nonSeparators.length, k);
    }
    {
      var separators = "\x0c\n\r\t\x0b ";
      Assert.isNull(new RegExp("\\S").exec(separators));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A3_T1.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_12_A3_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A3_T2.js>
   */
  @Test
  public function S15_10_2_12_A3_T2() {
    var regExp = new RegExp("\\w");
    // English small alphabet
    for (alpha in 0x0061...0x007a + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A3_T3.js>
   */
  @Test
  public function S15_10_2_12_A3_T3() {
    var regExp = new RegExp("\\w");
    {
      // digits
      for (alpha in 0x0030...0x0039 + 1) {
        var input:String = String.fromCharCode(alpha);
        var expectedMatch:Match = new Match(input, 0, [input]);
        var actualMatch:Match = regExp.exec(input);
        Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
      }
    }
    {
      // Underscore
      var input:String = "_";
      var expectedMatch:Match = new Match(input, 0, ["\u005f"]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    {
      // Space
      var actualMatch:Match = regExp.exec(" ");
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A3_T4.js>
   */
  @Test
  public function S15_10_2_12_A3_T4() {
    var regExp = new RegExp("\\w");
    // Russian capital alphabet
    for (alpha in 0x0410...0x042f + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
    // Russian small alphabet
    for (alpha in 0x0430...0x044f + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A3_T5.js>
   */
  @Test
  public function S15_10_2_12_A3_T5() {
    {
      var nonWordChars = "\x0c\n\r\t\x0b~`!@#$%^&*()-+={[}]|\\:;'<,>./? \"";
      Assert.isNull(new RegExp("\\w").exec(nonWordChars));
    }
    {
      var regExp = new RegExp("\\w", "g");
      var wordChars = "_0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
      var loopLimit = 200;
      var loopCount = 0;
      var k = 0;
      while (regExp.exec(wordChars) != null) {
        loopCount++;
        if (loopCount >= loopLimit) {
          Assert.fail("Infinite loop");
        }
        k++;
      }
      Assert.areEqual(wordChars.length, k);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A4_T1.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_12_A4_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A4_T2.js>
   */
  @Test
  public function S15_10_2_12_A4_T2() {
    var regExp = new RegExp("\\W");
    // English small alphabet
    for (alpha in 0x0061...0x007a + 1) {
      var input:String = String.fromCharCode(alpha);
      var actualMatch:Match = regExp.exec(input);
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A4_T3.js>
   */
  @Test
  public function S15_10_2_12_A4_T3() {
    var regExp = new RegExp("\\W");
    {
      // digits
      for (alpha in 0x0030...0x0039 + 1) {
        var input:String = String.fromCharCode(alpha);
        var actualMatch:Match = regExp.exec(input);
        Assert.isNull(actualMatch);
      }
    }
    {
      // Underscore
      var actualMatch:Match = regExp.exec("_");
      Assert.isNull(actualMatch);
    }
    {
      // Space
      var input:String = " ";
      var expectedMatch:Match = new Match(input, 0, ["\u0020"]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A4_T4.js>
   */
  @Test
  public function S15_10_2_12_A4_T4() {
    var regExp = new RegExp("\\S");
    // Russian capital alphabet
    for (alpha in 0x0410...0x042f + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    // Russian small alphabet
    for (alpha in 0x0430...0x044f + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A4_T5.js>
   */
  @Test
  public function S15_10_2_12_A4_T5() {
    {
      var regExp = new RegExp("\\W", "g");
      var nonWordChars = "\x0c\n\r\t\x0b~`!@#$%^&*()-+={[}]|\\:;'<,>./? \"";
      var loopLimit = 200;
      var loopCount = 0;
      var k = 0;
      while (regExp.exec(nonWordChars) != null) {
        loopCount++;
        if (loopCount >= loopLimit) {
          Assert.fail("Infinite loop");
        }
        k++;
      }
      Assert.areEqual(nonWordChars.length, k);
    }
    {
      var wordChars = "_0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
      Assert.isNull(new RegExp("\\W").exec(wordChars));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A5_T1.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_12_A5_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A5_T2.js>
   */
  @Test
  public function S15_10_2_12_A5_T2() {
    var regExp = new RegExp("\\d");
    // English capital alphabet
    for (alpha in 0x0041...0x005a + 1) {
      var input:String = String.fromCharCode(alpha);
      var actualMatch:Match = regExp.exec(input);
      Assert.isNull(actualMatch);
    }
    // English small alphabet
    for (alpha in 0x0061...0x007a + 1) {
      var input:String = String.fromCharCode(alpha);
      var actualMatch:Match = regExp.exec(input);
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A5_T3.js>
   */
  @Test
  public function S15_10_2_12_A5_T3() {
    var regExp = new RegExp("\\d");
    // Russian capital alphabet
    for (alpha in 0x0410...0x042f + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
    // Russian small alphabet
    for (alpha in 0x0430...0x044f + 1) {
      var actualMatch:Match = regExp.exec(String.fromCharCode(alpha));
      Assert.isNull(actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A5_T4.js>
   */
  @Test
  public function S15_10_2_12_A5_T4() {
    {
      var nonDecimals = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\x0c\n\r\t\x0b~`!@#$%^&*()-+={[}]|\\:;'<,>./? \"";
      Assert.isNull(new RegExp("\\d").exec(nonDecimals));
    }
    {
      var regExp = new RegExp("\\d", "g");
      var decimals = "0123456789";
      var loopLimit = 100;
      var loopCount = 0;
      var k = 0;
      while (regExp.exec(decimals) != null) {
        loopCount++;
        if (loopCount >= loopLimit) {
          Assert.fail("Infinite loop");
        }
        k++;
      }
      Assert.areEqual(decimals.length, k);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A6_T1.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_12_A6_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A6_T2.js>
   */
  @Test
  public function S15_10_2_12_A6_T2() {
    var regExp = new RegExp("\\D");
    // English capital alphabet
    for (alpha in 0x0041...0x005a + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    // English small alphabet
    for (alpha in 0x0061...0x007a + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A6_T3.js>
   */
  @Test
  public function S15_10_2_12_A6_T3() {
    var regExp = new RegExp("\\D");
    // Russian capital alphabet
    for (alpha in 0x0410...0x042f + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
    // Russian small alphabet
    for (alpha in 0x0430...0x044f + 1) {
      var input:String = String.fromCharCode(alpha);
      var expectedMatch:Match = new Match(input, 0, [input]);
      var actualMatch:Match = regExp.exec(input);
      Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.12_A6_T4.js>
   */
  @Test
  public function S15_10_2_12_A6_T4() {
    {
      var regExp = new RegExp("\\D", "g");
      var nonDecimals = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\x0c\n\r\t\x0b~`!@#$%^&*()-+={[}]|\\:;'<,>./? \"";
      var loopLimit = 100;
      var loopCount = 0;
      var k = 0;
      while (regExp.exec(nonDecimals) != null) {
        loopCount++;
        if (loopCount >= loopLimit) {
          Assert.fail("Infinite loop");
        }
        k++;
      }
      Assert.areEqual(nonDecimals.length, k);

    }
    {
      var decimals = "0123456789";
      Assert.isNull(new RegExp("\\D").exec(decimals));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T1.js>
   */
  @Test
  public function S15_10_2_13_A1_T1() {
    Assert.isFalse(new RegExp("[]a").test("\x00a\x00a"));
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T2.js>
   */
  @Test
  public function S15_10_2_13_A1_T2() {
    Assert.isFalse(new RegExp("a[]").test("\x00a\x00a"));
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T3.js>
   */
  @Ignore("Requires lookahead assertion")
  @Test
  public function S15_10_2_13_A1_T3() {
    var expectedMatch:Match = new Match("qYqy ", 2, ["qy"]);
    var actualMatch:Match = new RegExp("q[ax-zb](?=\\s+)").exec("qYqy ");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T4.js>
   */
  @Test
  public function S15_10_2_13_A1_T4() {
    var expectedMatch:Match = new Match("tqaqy ", 3, ["qy"]);
    var actualMatch:Match = new RegExp("q[ax-zb](?=\\s+)").exec("tqaqy ");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T5.js>
   */
  @Test
  public function S15_10_2_13_A1_T5() {
    var expectedMatch:Match = new Match("tqa\t  qy ", 1, ["qa"]);
    var actualMatch:Match = new RegExp("q[ax-zb](?=\\s+)").exec("tqa\t  qy ");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T6.js>
   */
  @Test
  public function S15_10_2_13_A1_T6() {
    var expectedMatch:Match = new Match("abcde", 0, ["abcde"]);
    var actualMatch:Match = new RegExp("ab[ercst]de").exec("abcde");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T7.js>
   */
  @Test
  public function S15_10_2_13_A1_T7() {
    var actualMatch:Match = new RegExp("ab[erst]de").exec("abcde");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T8.js>
   */
  @Test
  public function S15_10_2_13_A1_T8() {
    var expectedMatch:Match = new Match("abcdefghijkl", 3, ["defgh"]);
    var actualMatch:Match = new RegExp("[d-h]+").exec("abcdefghijkl");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T9.js>
   */
  @Test
  public function S15_10_2_13_A1_T9() {
    var expectedMatch:Match = new Match("abc6defghijkl", 3, ["6de"]);
    var actualMatch:Match = new RegExp("[1234567].{2}").exec("abc6defghijkl");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T10.js>
   */
  @Test
  public function S15_10_2_13_A1_T10() {
    var expectedMatch:Match = new Match("\n\nabc324234\n", 2, ["abc324234"]);
    var actualMatch:Match = new RegExp("[a-c\\d]+").exec("\n\nabc324234\n");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T11.js>
   */
  @Test
  public function S15_10_2_13_A1_T11() {
    var expectedMatch:Match = new Match("abc", 0, ["abc"]);
    var actualMatch:Match = new RegExp("ab[.]?c").exec("abc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T12.js>
   */
  @Test
  public function S15_10_2_13_A1_T12() {
    var expectedMatch:Match = new Match("abc", 0, ["abc"]);
    var actualMatch:Match = new RegExp("a[b]c").exec("abc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T13.js>
   */
  @Test
  public function S15_10_2_13_A1_T13() {
    var expectedMatch:Match = new Match("a1b  b2c  c3d  def  f4g", 15, ["def"]);
    var actualMatch:Match = new RegExp("[a-z][^1-9][a-z]").exec("a1b  b2c  c3d  def  f4g");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T14.js>
   */
  @Test
  public function S15_10_2_13_A1_T14() {
    var expectedMatch:Match = new Match("123*&$abc", 3, ["*&$"]);
    var actualMatch:Match = new RegExp("[*&$]{3}").exec("123*&$abc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T15.js>
   */
  @Test
  public function S15_10_2_13_A1_T15() {
    var expectedMatch:Match = new Match("line1\nline2", 4, ["1\nl"]);
    var actualMatch:Match = new RegExp("[\\d][\\n][^\\d]").exec("line1\nline2");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  // There is no S15_10_2_13_A1_T16

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A1_T17.js>
   */
  @Test
  public function S15_10_2_13_A1_T17() {
    var actualMatch:Match = new RegExp("[]").exec("a[b\n[]\tc]d");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T1.js>
   */
  @Test
  public function S15_10_2_13_A2_T1() {
    var expectedMatch:Match = new Match("a\naba", 1, ["\na"]);
    var actualMatch:Match = new RegExp("[^]a", "m").exec("a\naba");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T2.js>
   */
  @Test
  public function S15_10_2_13_A2_T2() {
    var expectedMatch:Match = new Match("   a\t\n", 3, ["a\t"]);
    var actualMatch:Match = new RegExp("a[^]").exec("   a\t\n");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T3.js>
   */
  @Test
  public function S15_10_2_13_A2_T3() {
    var expectedMatch:Match = new Match("ab an az aY n", 9, ["aY "]);
    var actualMatch:Match = new RegExp("a[^b-z]\\s+").exec("ab an az aY n");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T4.js>
   */
  @Test
  public function S15_10_2_13_A2_T4() {
    var expectedMatch:Match = new Match("easy\u0008to\u0008ride", 0, ["easy"]);
    var actualMatch:Match = new RegExp("[^\\b]+", "g").exec("easy\u0008to\u0008ride");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T5.js>
   */
  @Test
  public function S15_10_2_13_A2_T5() {
    var expectedMatch:Match = new Match("abc", 0, ["abc"]);
    var actualMatch:Match = new RegExp("a[^1-9]c").exec("abc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T6.js>
   */
  @Test
  public function S15_10_2_13_A2_T6() {
    var actualMatch:Match = new RegExp("a[^b]c").exec("abc");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T7.js>
   */
  @Test
  public function S15_10_2_13_A2_T7() {
    var expectedMatch:Match = new Match("abc#$%def%&*@ghi", 9, ["%&*@"]);
    var actualMatch:Match = new RegExp("[^a-z]{4}").exec("abc#$%def%&*@ghi");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A2_T8.js>
   */
  @Test
  public function S15_10_2_13_A2_T8() {
    var expectedMatch:Match = new Match("abc#$%def%&*@ghi", 0, ["a"]);
    var actualMatch:Match = new RegExp("[^]").exec("abc#$%def%&*@ghi");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A3_T1.js>
   */
  @Test
  public function S15_10_2_13_A3_T1() {
    var expectedMatch:Match = new Match("abc\u0008def", 2, ["c\u0008d"]);
    var actualMatch:Match = new RegExp(".[\\b].").exec("abc\u0008def");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A3_T2.js>
   */
  @Test
  public function S15_10_2_13_A3_T2() {
    var expectedMatch:Match = new Match("abc\u0008\u0008\u0008def", 2, ["c\u0008\u0008\u0008d"]);
    var actualMatch:Match = new RegExp("c[\\b]{3}d").exec("abc\u0008\u0008\u0008def");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A3_T3.js>
   */
  @Test
  public function S15_10_2_13_A3_T3() {
    var expectedMatch:Match = new Match("abc\u0008def", 0, ["abc"]);
    var actualMatch:Match = new RegExp("[^\\[\\b\\]]+").exec("abc\u0008def");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.13_A3_T4.js>
   */
  @Test
  public function S15_10_2_13_A3_T4() {
    var expectedMatch:Match = new Match("abcdef", 0, ["abcdef"]);
    var actualMatch:Match = new RegExp("[^\\[\\b\\]]+").exec("abcdef");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T1.js>
   */
  @Test
  public function S15_10_2_15_A1_T1() {
    AssertPattern.throwsSyntaxError("[b-ac-e]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T2.js>
   */
  @Test
  public function S15_10_2_15_A1_T2() {
    AssertPattern.throwsSyntaxError("[a-dc-b]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T3.js>
   */
  @Test
  public function S15_10_2_15_A1_T3() {
    AssertPattern.throwsSyntaxError("[\\db-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T4.js>
   */
  @Test
  public function S15_10_2_15_A1_T4() {
    AssertPattern.throwsSyntaxError("[\\Db-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T5.js>
   */
  @Test
  public function S15_10_2_15_A1_T5() {
    AssertPattern.throwsSyntaxError("[\\sb-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T6.js>
   */
  @Test
  public function S15_10_2_15_A1_T6() {
    AssertPattern.throwsSyntaxError("[\\Sb-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T7.js>
   */
  @Test
  public function S15_10_2_15_A1_T7() {
    AssertPattern.throwsSyntaxError("[\\wb-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T8.js>
   */
  @Test
  public function S15_10_2_15_A1_T8() {
    AssertPattern.throwsSyntaxError("[\\Wb-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T9.js>
   */
  @Test
  public function S15_10_2_15_A1_T9() {
    AssertPattern.throwsSyntaxError("[\\0b-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T10.js>
   */
  @Test
  public function S15_10_2_15_A1_T10() {
    AssertPattern.throwsSyntaxError("[\\10b-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T11.js>
   */
  @Test
  public function S15_10_2_15_A1_T11() {
    AssertPattern.throwsSyntaxError("[\\bd-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T12.js>
   */
  @Test
  public function S15_10_2_15_A1_T12() {
    AssertPattern.throwsSyntaxError("[\\Bd-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T13.js>
   */
  @Test
  public function S15_10_2_15_A1_T13() {
    AssertPattern.throwsSyntaxError("[\\td-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T14.js>
   */
  @Test
  public function S15_10_2_15_A1_T14() {
    AssertPattern.throwsSyntaxError("[\\nd-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T15.js>
   */
  @Test
  public function S15_10_2_15_A1_T15() {
    AssertPattern.throwsSyntaxError("[\\vd-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T16.js>
   */
  @Test
  public function S15_10_2_15_A1_T16() {
    AssertPattern.throwsSyntaxError("[\\fd-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T17.js>
   */
  @Test
  public function S15_10_2_15_A1_T17() {
    AssertPattern.throwsSyntaxError("[\\rd-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T18.js>
   */
  @Test
  public function S15_10_2_15_A1_T18() {
    AssertPattern.throwsSyntaxError("[\\c0001d-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T19.js>
   */
  @Test
  public function S15_10_2_15_A1_T19() {
    AssertPattern.throwsSyntaxError("[\\x0061d-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T20.js>
   */
  @Test
  public function S15_10_2_15_A1_T20() {
    AssertPattern.throwsSyntaxError("[\\u0061d-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T21.js>
   */
  @Test
  public function S15_10_2_15_A1_T21() {
    AssertPattern.throwsSyntaxError("[\\ad-G]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T22.js>
   */
  @Test
  public function S15_10_2_15_A1_T22() {
    AssertPattern.throwsSyntaxError("[c-eb-a]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T23.js>
   */
  @Test
  public function S15_10_2_15_A1_T23() {
    AssertPattern.throwsSyntaxError("[b-G\\d]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T24.js>
   */
  @Test
  public function S15_10_2_15_A1_T24() {
    AssertPattern.throwsSyntaxError("[b-G\\D]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T25.js>
   */
  @Test
  public function S15_10_2_15_A1_T25() {
    AssertPattern.throwsSyntaxError("[b-G\\s]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T26.js>
   */
  @Test
  public function S15_10_2_15_A1_T26() {
    AssertPattern.throwsSyntaxError("[b-G\\S]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T27.js>
   */
  @Test
  public function S15_10_2_15_A1_T27() {
    AssertPattern.throwsSyntaxError("[b-G\\w]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T28.js>
   */
  @Test
  public function S15_10_2_15_A1_T28() {
    AssertPattern.throwsSyntaxError("[b-G\\W]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T29.js>
   */
  @Test
  public function S15_10_2_15_A1_T29() {
    AssertPattern.throwsSyntaxError("[b-G\\0]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T30.js>
   */
  @Test
  public function S15_10_2_15_A1_T30() {
    AssertPattern.throwsSyntaxError("[b-G\\10]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T31.js>
   */
  @Test
  public function S15_10_2_15_A1_T31() {
    AssertPattern.throwsSyntaxError("[b-G\\b]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T32.js>
   */
  @Test
  public function S15_10_2_15_A1_T32() {
    AssertPattern.throwsSyntaxError("[b-G\\B]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T33.js>
   */
  @Test
  public function S15_10_2_15_A1_T33() {
    AssertPattern.throwsSyntaxError("[b-G\\t]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T34.js>
   */
  @Test
  public function S15_10_2_15_A1_T34() {
    AssertPattern.throwsSyntaxError("[b-G\\n]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T35.js>
   */
  @Test
  public function S15_10_2_15_A1_T35() {
    AssertPattern.throwsSyntaxError("[b-G\\v]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T36.js>
   */
  @Test
  public function S15_10_2_15_A1_T36() {
    AssertPattern.throwsSyntaxError("[b-G\\f]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T37.js>
   */
  @Test
  public function S15_10_2_15_A1_T37() {
    AssertPattern.throwsSyntaxError("[b-G\\r]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T38.js>
   */
  @Test
  public function S15_10_2_15_A1_T38() {
    AssertPattern.throwsSyntaxError("[b-G\\c0001]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T39.js>
   */
  @Test
  public function S15_10_2_15_A1_T39() {
    AssertPattern.throwsSyntaxError("[b-G\\x0061]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T40.js>
   */
  @Test
  public function S15_10_2_15_A1_T40() {
    AssertPattern.throwsSyntaxError("[b-G\\u0061]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.15_A1_T41.js>
   */
  @Test
  public function S15_10_2_15_A1_T41() {
    AssertPattern.throwsSyntaxError("[b-G\\a]");
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T1.js>
   */
  @Test
  public function S15_10_2_3_A1_T1() {
    var patternSource:String = "a|ab";
    var input:String = "abc";
    var expectedMatch:Match = new Match(input, 0, ["a"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T2.js>
   */
  @Test
  public function S15_10_2_3_A1_T2() {
    var patternSource:String = "((a)|(ab))((c)|(bc))";
    var input:String = "abc";
    var expectedMatch:Match = new Match(input, 0, ["abc", "a", "a", null, "bc", null, "bc"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T3.js>
   */
  @Test
  public function S15_10_2_3_A1_T3() {
    var patternSource:String = "\\d{3}|[a-z]{4}";
    var input:String = "2, 12 and of course repeat 12";
    var expectedMatch:Match = new Match(input, 13, ["cour"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T4.js>
   */
  @Test
  public function S15_10_2_3_A1_T4() {
    var patternSource:String = "\\d{3}|[a-z]{4}";
    var input:String = "2, 12 and 234 AND of course repeat 12";
    var expectedMatch:Match = new Match(input, 10, ["234"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T5.js>
   */
  @Test
  public function S15_10_2_3_A1_T5() {
    var patternSource:String = "\\d{3}|[a-z]{4}";
    var input:String = "2, 12 and 23 AND 0.00.1";
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T6.js>
   */
  @Test
  public function S15_10_2_3_A1_T6() {
    var patternSource:String = "ab|cd|ef";
    var input:String = "AEKFCD";
    var expectedMatch:Match = new Match(input, 4, ["CD"]);
    var actualMatch:Match = new RegExp(patternSource, "i").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T7.js>
   */
  @Test
  public function S15_10_2_3_A1_T7() {
    var patternSource:String = "ab|cd|ef";
    var input:String = "AEKFCD";
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T8.js>
   */
  @Test
  public function S15_10_2_3_A1_T8() {
    var patternSource:String = "(?:ab|cd)+|ef";
    var input:String = "AEKFCD";
    var expectedMatch:Match = new Match(input, 4, ["CD"]);
    var actualMatch:Match = new RegExp(patternSource, "i").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T9.js>
   */
  @Test
  public function S15_10_2_3_A1_T9() {
    var patternSource:String = "(?:ab|cd)+|ef";
    var input:String = "AEKFCDab";
    var expectedMatch:Match = new Match(input, 4, ["CDab"]);
    var actualMatch:Match = new RegExp(patternSource, "i").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T10.js>
   */
  @Test
  public function S15_10_2_3_A1_T10() {
    var patternSource:String = "(?:ab|cd)+|ef";
    var input:String = "AEKeFCDab";
    var expectedMatch:Match = new Match(input, 3, ["eF"]);
    var actualMatch:Match = new RegExp(patternSource, "i").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T11.js>
   */
  @Test
  public function S15_10_2_3_A1_T11() {
    var patternSource:String = "11111|111";
    var input:String = "1111111111111111";
    var expectedMatch:Match = new Match(input, 0, ["11111"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T12.js>
   */
  @Test
  public function S15_10_2_3_A1_T12() {
    var patternSource:String = "xyz|...";
    var input:String = "abc";
    var expectedMatch:Match = new Match(input, 0, ["abc"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T13.js>
   */
  @Test
  public function S15_10_2_3_A1_T13() {
    var patternSource:String = "(.)..|abc";
    var input:String = "abc";
    var expectedMatch:Match = new Match(input, 0, ["abc", "a"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T14.js>
   */
  @Test
  public function S15_10_2_3_A1_T14() {
    var patternSource:String = ".+: gr(a|e)y";
    var input:String = "color: grey";
    var expectedMatch:Match = new Match(input, 0, ["color: grey", "e"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T15.js>
   */
  @Test
  public function S15_10_2_3_A1_T15() {
    var patternSource:String = "(Rob)|(Bob)|(Robert)|(Bobby)";
    var input:String = "Hi Bob";
    var expectedMatch:Match = new Match(input, 3, ["Bob", null, "Bob", null, null]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T16.js>
   */
  @Test
  public function S15_10_2_3_A1_T16() {
    var patternSource:String = "()";
    var input:String = "";
    var expectedMatch:Match = new Match(input, 0, ["", ""]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.3_A1_T17.js>
   */
  @Test
  public function S15_10_2_3_A1_T17() {
    var patternSource:String = "|()";
    var input:String = "";
    var expectedMatch:Match = new Match(input, 0, ["", null]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.5_A1_T1.js>
   */
  @Test
  public function S15_10_2_5_A1_T1() {
    var patternSource:String = "a[a-z]{2,4}";
    var input:String = "abcdefghi";
    var expectedMatch:Match = new Match("abcdefghi", 0, ["abcde"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.5_A1_T2.js>
   */
  @Test
  public function S15_10_2_5_A1_T2() {
    var patternSource:String = "a[a-z]{2,4}?";
    var input:String = "abcdefghi";
    var expectedMatch:Match = new Match("abcdefghi", 0, ["abc"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.5_A1_T3.js>
   */
  @Test
  public function S15_10_2_5_A1_T3() {
    var patternSource:String = "(aa|aabaac|ba|b|c)*";
    var input:String = "aabaac";
    var expectedMatch:Match = new Match("aabaac", 0, ["aaba", "ba"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.5_A1_T4.js>
   */
  @Test
  public function S15_10_2_5_A1_T4() {
    var patternSource:String = "(z)((a+)?(b+)?(c))*";
    var input:String = "zaacbbbcac";
    var expectedMatch:Match = new Match("zaacbbbcac", 0, ["zaacbbbcac", "z", "ac", "a", null, "c"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.5_A1_T5.js>
   */
  @Ignore("Requires backreferences")
  @Test
  public function S15_10_2_5_A1_T5() {
    var patternSource:String = "(a*)b\\1+";
    var input:String = "baaaac";
    var expectedMatch:Match = new Match("baaaac", 0, ["b", ""]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A1_T1.js>
   */
  @Test
  public function S15_10_2_6_A1_T1() {
    var patternSource:String = "s$";
    var input:String = "pairs\nmakes\tdouble";
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A1_T2.js>
   */
  @Test
  public function S15_10_2_6_A1_T2() {
    var patternSource:String = "e$";
    var input:String = "pairs\nmakes\tdouble";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble", 17, ["e"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A1_T3.js>
   */
  @Test
  public function S15_10_2_6_A1_T3() {
    var patternSource:String = "s$";
    var input:String = "pairs\nmakes\tdouble";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble", 4, ["s"]);
    var actualMatch:Match = new RegExp(patternSource, "m").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A1_T4.js>
   */
  @Test
  public function S15_10_2_6_A1_T4() {
    var patternSource:String = "[^e]$";
    var input:String = "pairs\nmakes\tdouble";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble", 4, ["s"]);
    var actualMatch:Match = new RegExp(patternSource, "mg").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A1_T5.js>
   */
  @Test
  public function S15_10_2_6_A1_T5() {
    var patternSource:String = "es$";
    var input:String = "pairs\nmakes\tdoubl\u0065s";
    var expectedMatch:Match = new Match("pairs\nmakes\tdoubles", 17, ["es"]);
    var actualMatch:Match = new RegExp(patternSource, "mg").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T1.js>
   */
  @Test
  public function S15_10_2_6_A2_T1() {
    var patternSource:String = "^m";
    var input:String = "pairs\nmakes\tdouble";
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T2.js>
   */
  @Test
  public function S15_10_2_6_A2_T2() {
    var patternSource:String = "^m";
    var input:String = "pairs\nmakes\tdouble";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble", 6, ["m"]);
    var actualMatch:Match = new RegExp(patternSource, "m").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T3.js>
   */
  @Test
  public function S15_10_2_6_A2_T3() {
    var patternSource:String = "^p[a-z]";
    var input:String = "pairs\nmakes\tdouble";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble", 0, ["pa"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T4.js>
   */
  @Test
  public function S15_10_2_6_A2_T4() {
    var patternSource:String = "^p[b-z]";
    var input:String = "pairs\nmakes\tdouble\npesos";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble\npesos", 19, ["pe"]);
    var actualMatch:Match = new RegExp(patternSource, "m").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T5.js>
   */
  @Test
  public function S15_10_2_6_A2_T5() {
    var patternSource:String = "^[^p]";
    var input:String = "pairs\nmakes\tdouble\npesos";
    var expectedMatch:Match = new Match("pairs\nmakes\tdouble\npesos", 6, ["m"]);
    var actualMatch:Match = new RegExp(patternSource, "m").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T6.js>
   */
  @Test
  public function S15_10_2_6_A2_T6() {
    var patternSource:String = "^ab";
    var input:String = "abcde";
    var expectedMatch:Match = new Match(input, 0, ["ab"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T7.js>
   */
  @Test
  public function S15_10_2_6_A2_T7() {
    Assert.isFalse(new RegExp("^..^e").test("ab\ncde"));
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T8.js>
   */
  @Test
  public function S15_10_2_6_A2_T8() {
    Assert.isFalse(new RegExp("^xxx").test("yyyyy"));
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T9.js>
   */
  @Test
  public function S15_10_2_6_A2_T9() {
    var patternSource:String = "^\\^+";
    var input:String = "^^^x";
    var expectedMatch:Match = new Match("^^^x", 0, ["^^^"]);
    var actualMatch:Match = new RegExp(patternSource).exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A2_T10.js>
   */
  @Test
  public function S15_10_2_6_A2_T10() {
    var patternSource:String = "^\\d+";
    var input:String = "abc\n123xyz";
    var expectedMatch:Match = new Match("abc\n123xyz", 4, ["123"]);
    var actualMatch:Match = new RegExp(patternSource, "m").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T1.js>
   */
  @Test
  public function S15_10_2_6_A3_T1() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 0, ["p"]);
    var actualMatch:Match = new RegExp("\\bp").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T2.js>
   */
  @Test
  public function S15_10_2_6_A3_T2() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 3, ["ot"]);
    var actualMatch:Match = new RegExp("ot\\b").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T3.js>
   */
  @Test
  public function S15_10_2_6_A3_T3() {
    var actualMatch:Match = new RegExp("\\bot").exec("pilot\nsoviet robot\topenoffice");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T4.js>
   */
  @Test
  public function S15_10_2_6_A3_T4() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 6, ["so"]);
    var actualMatch:Match = new RegExp("\\bso").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T5.js>
   */
  @Test
  public function S15_10_2_6_A3_T5() {
    var actualMatch:Match = new RegExp("so\\b").exec("pilot\nsoviet robot\topenoffice");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T6.js>
   */
  @Test
  public function S15_10_2_6_A3_T6() {
    var expectedMatch:Match = new Match("pilOt\nsoviet robot\topenoffice", 3, ["Ot"]);
    var actualMatch:Match = new RegExp("[^o]t\\b").exec("pilOt\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T7.js>
   */
  @Test
  public function S15_10_2_6_A3_T7() {
    var expectedMatch:Match = new Match("pilOt\nsoviet robot\topenoffice", 10, ["et"]);
    var actualMatch:Match = new RegExp("[^o]t\\b", "i").exec("pilOt\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T8.js>
   */
  @Test
  public function S15_10_2_6_A3_T8() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 13, ["ro"]);
    var actualMatch:Match = new RegExp("\\bro").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T9.js>
   */
  @Test
  public function S15_10_2_6_A3_T9() {
    var actualMatch:Match = new RegExp("r\\b").exec("pilot\nsoviet robot\topenoffice");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T10.js>
   */
  @Test
  public function S15_10_2_6_A3_T10() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 13, ["robot"]);
    var actualMatch:Match = new RegExp("\\brobot\\b").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T11.js>
   */
  @Test
  public function S15_10_2_6_A3_T11() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 0, ["pilot"]);
    var actualMatch:Match = new RegExp("\\b\\w{5}\\b").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T12.js>
   */
  @Test
  public function S15_10_2_6_A3_T12() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffice", 19, ["op"]);
    var actualMatch:Match = new RegExp("\\bop").exec("pilot\nsoviet robot\topenoffice");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T13.js>
   */
  @Test
  public function S15_10_2_6_A3_T13() {
    var actualMatch:Match = new RegExp("op\\b").exec("pilot\nsoviet robot\topenoffice");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T14.js>
   */
  @Test
  public function S15_10_2_6_A3_T14() {
    var expectedMatch:Match = new Match("pilot\nsoviet robot\topenoffic\u0065", 28, ["e"]);
    var actualMatch:Match = new RegExp("e\\b").exec("pilot\nsoviet robot\topenoffic\u0065");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A3_T15.js>
   */
  @Test
  public function S15_10_2_6_A3_T15() {
    var actualMatch:Match = new RegExp("\\be").exec("pilot\nsoviet robot\topenoffic\u0065");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T1.js>
   */
  @Test
  public function S15_10_2_6_A4_T1() {
    var expectedMatch:Match = new Match("devils arise\tfor\nevil", 1, ["evil"]);
    var actualMatch:Match = new RegExp("\\Bevil\\B").exec("devils arise\tfor\nevil");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T2.js>
   */
  @Test
  public function S15_10_2_6_A4_T2() {
    var expectedMatch:Match = new Match("devils arise\tfor\nrevil", 17, ["re"]);
    var actualMatch:Match = new RegExp("[f-z]e\\B").exec("devils arise\tfor\nrevil");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T3.js>
   */
  @Test
  public function S15_10_2_6_A4_T3() {
    var expectedMatch:Match = new Match("devils arise\tfOr\nrevil", 14, ["O"]);
    var actualMatch:Match = new RegExp("\\Bo\\B", "i").exec("devils arise\tfOr\nrevil");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T4.js>
   */
  @Test
  public function S15_10_2_6_A4_T4() {
    var expectedMatch:Match = new Match("devils arise\tfor\nrevil", 1, ["e"]);
    var actualMatch:Match = new RegExp("\\B\\w\\B").exec("devils arise\tfor\nrevil");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T5.js>
   */
  @Test
  public function S15_10_2_6_A4_T5() {
    var expectedMatch:Match = new Match("devils arise\tfor\nrevil", 0, ["d"]);
    var actualMatch:Match = new RegExp("\\w\\B").exec("devils arise\tfor\nrevil");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T6.js>
   */
  @Test
  public function S15_10_2_6_A4_T6() {
    var expectedMatch:Match = new Match("devils arise\tfor\nrevil", 1, ["e"]);
    var actualMatch:Match = new RegExp("\\B\\w").exec("devils arise\tfor\nrevil");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T7.js>
   */
  @Test
  public function S15_10_2_6_A4_T7() {
    var expectedMatch:Match = new Match("devil arise\tforzzx\nevils", 3, ["il a"]);
    var actualMatch:Match = new RegExp("\\B[^z]{4}\\B").exec("devil arise\tforzzx\nevils");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A4_T8.js>
   */
  @Test
  public function S15_10_2_6_A4_T8() {
    var expectedMatch:Match = new Match("devil arise\tforzzx\nevils", 13, ["orzz"]);
    var actualMatch:Match = new RegExp("\\B\\w{4}\\B").exec("devil arise\tforzzx\nevils");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A5_T1.js>
   */
  @Test
  public function S15_10_2_6_A5_T1() {
    var expectedMatch:Match = new Match("robot", 0, ["robot"]);
    var actualMatch:Match = new RegExp("^^^^^^^robot$$$$").exec("robot");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A5_T2.js>
   */
  @Test
  public function S15_10_2_6_A5_T2() {
    var expectedMatch:Match = new Match("robot wall-e", 2, ["bot"]);
    var actualMatch:Match = new RegExp("\\B\\B\\B\\B\\B\\Bbot\\b\\b\\b\\b\\b\\b\\b").exec("robot wall-e");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A6_T1.js>
   */
  @Test
  public function S15_10_2_6_A6_T1() {
    var expectedMatch:Match = new Match("Hello World", 0, ["Hello World"]);
    var actualMatch:Match = new RegExp("^.*?$").exec("Hello World");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A6_T2.js>
   */
  @Test
  public function S15_10_2_6_A6_T2() {
    var expectedMatch:Match = new Match("Hello World", 0, [""]);
    var actualMatch:Match = new RegExp("^.*?").exec("Hello World");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A6_T3.js>
   */
  @Test
  public function S15_10_2_6_A6_T3() {
    var expectedMatch:Match = new Match("Hello: World", 0, ["Hello:", ":"]);
    var actualMatch:Match = new RegExp("^.*?(:|$)").exec("Hello: World");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.6_A6_T4.js>
   */
  @Test
  public function S15_10_2_6_A6_T4() {
    var expectedMatch:Match = new Match("Hello: World", 0, ["Hello: World", ""]);
    var actualMatch:Match = new RegExp("^.*(:|$)").exec("Hello: World");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T1.js>
   */
  @Test
  public function S15_10_2_7_A1_T1() {
    var expectedMatch:Match = new Match("the answer is 42", 14, ["42"]);
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("the answer is 42");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T2.js>
   */
  @Test
  public function S15_10_2_7_A1_T2() {
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("the 7 movie");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T3.js>
   */
  @Test
  public function S15_10_2_7_A1_T3() {
    var expectedMatch:Match = new Match("the 20000 Leagues Under the Sea book", 4, ["2000"]);
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("the 20000 Leagues Under the Sea book");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T4.js>
   */
  @Test
  public function S15_10_2_7_A1_T4() {
    var expectedMatch:Match = new Match("the Fahrenheit 451 book", 15, ["451"]);
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("the Fahrenheit 451 book");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T5.js>
   */
  @Test
  public function S15_10_2_7_A1_T5() {
    var expectedMatch:Match = new Match("the 1984 novel", 4, ["1984"]);
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("the 1984 novel");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T6.js>
   */
  @Test
  public function S15_10_2_7_A1_T6() {
    var expectedMatch:Match = new Match("0a011b", 2, ["011"]);
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("0a0\u0031\u0031b");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T7.js>
   */
  @Test
  public function S15_10_2_7_A1_T7() {
    var expectedMatch:Match = new Match("0a01122b", 2, ["0112"]);
    var actualMatch:Match = new RegExp("\\d{2,4}").exec("0a0\u0031\u003122b");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T8.js>
   */
  @Test
  public function S15_10_2_7_A1_T8() {
    var expectedMatch:Match = new Match("aaabbbbcccddeeeefffff", 4, ["bbbc"]);
    var actualMatch:Match = new RegExp("b{2,3}c").exec("aaabbbbcccddeeeefffff");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T9.js>
   */
  @Test
  public function S15_10_2_7_A1_T9() {
    var actualMatch:Match = new RegExp("b{42,93}c").exec("aaabbbbcccddeeeefffff");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T10.js>
   */
  @Test
  public function S15_10_2_7_A1_T10() {
    var expectedMatch:Match = new Match("aaabbbbcccddeeeefffff", 3, ["bbbbc"]);
    var actualMatch:Match = new RegExp("b{0,93}c").exec("aaabbbbcccddeeeefffff");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T11.js>
   */
  @Test
  public function S15_10_2_7_A1_T11() {
    var expectedMatch:Match = new Match("aaabbbbcccddeeeefffff", 6, ["bc"]);
    var actualMatch:Match = new RegExp("bx{0,93}c").exec("aaabbbbcccddeeeefffff");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A1_T12.js>
   */
  @Test
  public function S15_10_2_7_A1_T12() {
    var expectedMatch:Match = new Match("weirwerdf", 0, ["weirwerdf"]);
    var actualMatch:Match = new RegExp(".{0,93}").exec("weirwerdf");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A2_T1.js>
   */
  @Test
  public function S15_10_2_7_A2_T1() {
    var expectedMatch:Match = new Match("CE\uFFFFL\uFFDDbox127", 5, ["box1"]);
    var actualMatch:Match = new RegExp("\\w{3}\\d?").exec("CE\uFFFFL\uFFDDbox127");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A2_T2.js>
   */
  @Test
  public function S15_10_2_7_A2_T2() {
    var expectedMatch:Match = new Match("CELL\uFFDDbox127", 0, ["CEL"]);
    var actualMatch:Match = new RegExp("\\w{3}\\d?").exec("CELL\uFFDDbox127");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A2_T3.js>
   */
  @Test
  public function S15_10_2_7_A2_T3() {
    var expectedMatch:Match = new Match("aaabbbbcccddeeeefffff", 5, ["bbc"]);
    var actualMatch:Match = new RegExp("b{2}c").exec("aaabbbbcccddeeeefffff");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A2_T4.js>
   */
  @Test
  public function S15_10_2_7_A2_T4() {
    var actualMatch:Match = new RegExp("b{8}").exec("aaabbbbcccddeeeefffff");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T1.js>
   */
  @Test
  public function S15_10_2_7_A3_T1() {
    var expectedMatch:Match = new Match("language  java\n", 8, ["  java\n"]);
    var actualMatch:Match = new RegExp("\\s+java\\s+").exec("language  java\n");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T2.js>
   */
  @Test
  public function S15_10_2_7_A3_T2() {
    var expectedMatch:Match = new Match("\t java object", 0, ["\t java "]);
    var actualMatch:Match = new RegExp("\\s+java\\s+").exec("\t java object");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T3.js>
   */
  @Test
  public function S15_10_2_7_A3_T3() {
    var actualMatch:Match = new RegExp("\\s+java\\s+").exec("\t javax package");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T4.js>
   */
  @Test
  public function S15_10_2_7_A3_T4() {
    var actualMatch:Match = new RegExp("\\s+java\\s+").exec("java\n\nobject");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T5.js>
   */
  @Test
  public function S15_10_2_7_A3_T5() {
    var expectedMatch:Match = new Match("x 2 ff 55 x2 as1 z12 abc12.0", 10, ["x2"]);
    var actualMatch:Match = new RegExp("[a-z]+\\d+").exec("x 2 ff 55 x2 as1 z12 abc12.0");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T6.js>
   */
  @Test
  public function S15_10_2_7_A3_T6() {
    var expectedMatch:Match = new Match("__abc123.0", 2, ["abc123"]);
    var actualMatch:Match = new RegExp("[a-z]+\\d+").exec("__abc123.0");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T7.js>
   */
  @Test
  public function S15_10_2_7_A3_T7() {
    var expectedMatch:Match = new Match("x 2 ff 55 x2 as1 z12 abc12.0", 10, ["x2", "2"]);
    var actualMatch:Match = new RegExp("[a-z]+(\\d+)").exec("x 2 ff 55 x2 as1 z12 abc12.0");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T8.js>
   */
  @Test
  public function S15_10_2_7_A3_T8() {
    var expectedMatch:Match = new Match("__abc123.0", 2, ["abc123", "123"]);
    var actualMatch:Match = new RegExp("[a-z]+(\\d+)").exec("__abc123.0");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T9.js>
   */
  @Test
  public function S15_10_2_7_A3_T9() {
    var expectedMatch:Match = new Match("abcdddddefg", 3, ["ddddd"]);
    var actualMatch:Match = new RegExp("d+").exec("abcdddddefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T10.js>
   */
  @Test
  public function S15_10_2_7_A3_T10() {
    var actualMatch:Match = new RegExp("o+").exec("abcdefg");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T11.js>
   */
  @Test
  public function S15_10_2_7_A3_T11() {
    var expectedMatch:Match = new Match("abcdefg", 3, ["d"]);
    var actualMatch:Match = new RegExp("d+").exec("abcdefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T12.js>
   */
  @Test
  public function S15_10_2_7_A3_T12() {
    var expectedMatch:Match = new Match("abbbbbbbc", 1, ["bbbbbbb","bbbbb","b","b"]);
    var actualMatch:Match = new RegExp("(b+)(b+)(b+)").exec("abbbbbbbc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T13.js>
   */
  @Test
  public function S15_10_2_7_A3_T13() {
    var expectedMatch:Match = new Match("abbbbbbbc", 1, ["bbbbbbb","bbbbbbb",""]);
    var actualMatch:Match = new RegExp("(b+)(b*)").exec("abbbbbbbc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A3_T14.js>
   */
  @Test
  public function S15_10_2_7_A3_T14() {
    var expectedMatch:Match = new Match("abbbbbbbc", 1, ["bbbbbbb"]);
    var actualMatch:Match = new RegExp("b*b+").exec("abbbbbbbc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T1.js>
   */
  @Test
  public function S15_10_2_7_A4_T1() {
    var expectedMatch:Match = new Match("\"beast\"-nickname", 0, [""]);
    var actualMatch:Match = new RegExp("[^\"]*").exec("\"beast\"-nickname");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T2.js>
   */
  @Test
  public function S15_10_2_7_A4_T2() {
    var expectedMatch:Match = new Match("alice said: \"don't\"", 0, ["alice said: "]);
    var actualMatch:Match = new RegExp("[^\"]*").exec("alice said: \"don't\"");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T3.js>
   */
  @Test
  public function S15_10_2_7_A4_T3() {
    var expectedMatch:Match = new Match("before'i'start", 0, ["before'i'start"]);
    var actualMatch:Match = new RegExp("[^\"]*").exec("before'i'start");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T4.js>
   */
  @Test
  public function S15_10_2_7_A4_T4() {
    var expectedMatch:Match = new Match("alice \"sweep\": \"don't\"", 0, ["alice "]);
    var actualMatch:Match = new RegExp("[^\"]*").exec("alice \"sweep\": \"don't\"");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T5.js>
   */
  @Test
  public function S15_10_2_7_A4_T5() {
    var expectedMatch:Match = new Match("alice \u0022sweep\u0022: \"don't\"", 0, ["alice "]);
    var actualMatch:Match = new RegExp("[^\"]*").exec("alice \u0022sweep\u0022: \"don't\"");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T6.js>
   */
  @Test
  public function S15_10_2_7_A4_T6() {
    var expectedMatch:Match = new Match("alice \u0022sweep\u0022: \"don't\"", 6, ["\"sweep\""]);
    var actualMatch:Match = new RegExp("[\"'][^\"']*[\"']").exec("alice \u0022sweep\u0022: \"don't\"");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T7.js>
   */
  @Test
  public function S15_10_2_7_A4_T7() {
    var expectedMatch:Match = new Match("alice cries out: 'don't'", 17, ["'don'"]);
    var actualMatch:Match = new RegExp("[\"'][^\"']*[\"']").exec("alice cries out: 'don't'");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T8.js>
   */
  @Test
  public function S15_10_2_7_A4_T8() {
    var actualMatch:Match = new RegExp("[\"'][^\"']*[\"']").exec("alice cries out: don't");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T9.js>
   */
  @Test
  public function S15_10_2_7_A4_T9() {
    var expectedMatch:Match = new Match("alice cries out:\"\"", 16, ["\"\""]);
    var actualMatch:Match = new RegExp("[\"'][^\"']*[\"']").exec("alice cries out:\"\"");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T10.js>
   */
  @Test
  public function S15_10_2_7_A4_T10() {
    var expectedMatch:Match = new Match("abcddddefg", 0, [""]);
    var actualMatch:Match = new RegExp("d*").exec("abcddddefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T11.js>
   */
  @Test
  public function S15_10_2_7_A4_T11() {
    var expectedMatch:Match = new Match("abcddddefg", 2, ["cdddd"]);
    var actualMatch:Match = new RegExp("cd*").exec("abcddddefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T12.js>
   */
  @Test
  public function S15_10_2_7_A4_T12() {
    var expectedMatch:Match = new Match("abcdefg", 2, ["cd"]);
    var actualMatch:Match = new RegExp("cx*d").exec("abcdefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T13.js>
   */
  @Test
  public function S15_10_2_7_A4_T13() {
    var expectedMatch:Match = new Match("xxxxxxx", 0, ["xxxxxxx","xxxxxx","x"]);
    var actualMatch:Match = new RegExp("(x*)(x+)").exec("xxxxxxx");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T14.js>
   */
  @Test
  public function S15_10_2_7_A4_T14() {
    var expectedMatch:Match = new Match("1234567890", 0, ["1234567890","123456789","0"]);
    var actualMatch:Match = new RegExp("(\\d*)(\\d+)").exec("1234567890");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T15.js>
   */
  @Test
  public function S15_10_2_7_A4_T15() {
    var expectedMatch:Match = new Match("1234567890", 0, ["1234567890","12345678","0"]);
    var actualMatch:Match = new RegExp("(\\d*)\\d(\\d+)").exec("1234567890");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T16.js>
   */
  @Test
  public function S15_10_2_7_A4_T16() {
    var expectedMatch:Match = new Match("xxxxxxx", 0, ["xxxxxxx","xxxxxxx",""]);
    var actualMatch:Match = new RegExp("(x+)(x*)").exec("xxxxxxx");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T17.js>
   */
  @Test
  public function S15_10_2_7_A4_T17() {
    var expectedMatch:Match = new Match("xxxxxxyyyyyy", 0, ["xxxxxxyyyyyy"]);
    var actualMatch:Match = new RegExp("x*y+$").exec("xxxxxxyyyyyy");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T18.js>
   */
  @Test
  public function S15_10_2_7_A4_T18() {
    var expectedMatch:Match = new Match("abcdef", 1, ["bcd"]);
    var actualMatch:Match = new RegExp("[\\d]*[\\s]*bc.").exec("abcdef");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T19.js>
   */
  @Test
  public function S15_10_2_7_A4_T19() {
    var expectedMatch:Match = new Match("abcdef", 1, ["bcde"]);
    var actualMatch:Match = new RegExp("bc..[\\d]*[\\s]*").exec("abcdef");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T20.js>
   */
  @Test
  public function S15_10_2_7_A4_T20() {
    var expectedMatch:Match = new Match("a1b2c3", 0, ["a1b2c3"]);
    var actualMatch:Match = new RegExp(".*").exec("a1b2c3");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A4_T21.js>
   */
  @Test
  public function S15_10_2_7_A4_T21() {
    var actualMatch:Match = new RegExp("[xyz]*1").exec("a0.b2.c3");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T1.js>
   */
  @Test
  public function S15_10_2_7_A5_T1() {
    var expectedMatch:Match = new Match("state: javascript is extension of ecma script", 7, ["javascript", "script"]);
    var actualMatch:Match = new RegExp("java(script)?").exec("state: javascript is extension of ecma script");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T2.js>
   */
  @Test
  public function S15_10_2_7_A5_T2() {
    var expectedMatch:Match = new Match("state: java and javascript are vastly different", 7, ["java", null]);
    var actualMatch:Match = new RegExp("java(script)?").exec("state: java and javascript are vastly different");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T3.js>
   */
  @Test
  public function S15_10_2_7_A5_T3() {
    var actualMatch:Match = new RegExp("java(script)?").exec("state: both Java and JavaScript used in web development");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T4.js>
   */
  @Test
  public function S15_10_2_7_A5_T4() {
    var expectedMatch:Match = new Match("abcdef", 2, ["cde"]);
    var actualMatch:Match = new RegExp("cd?e").exec("abcdef");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T5.js>
   */
  @Test
  public function S15_10_2_7_A5_T5() {
    var expectedMatch:Match = new Match("abcdef", 2, ["cde"]);
    var actualMatch:Match = new RegExp("cdx?e").exec("abcdef");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T6.js>
   */
  @Test
  public function S15_10_2_7_A5_T6() {
    var expectedMatch:Match = new Match("pqrstuvw", 0, ["pqrst"]);
    var actualMatch:Match = new RegExp("o?pqrst").exec("pqrstuvw");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T7.js>
   */
  @Test
  public function S15_10_2_7_A5_T7() {
    var expectedMatch:Match = new Match("abcd", 0, [""]);
    var actualMatch:Match = new RegExp("x?y?z?").exec("abcd");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T8.js>
   */
  @Test
  public function S15_10_2_7_A5_T8() {
    var expectedMatch:Match = new Match("abcd", 0, ["abc"]);
    var actualMatch:Match = new RegExp("x?ay?bz?c").exec("abcd");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T9.js>
   */
  @Test
  public function S15_10_2_7_A5_T9() {
    var expectedMatch:Match = new Match("abbbbc", 1, ["bbbb"]);
    var actualMatch:Match = new RegExp("b?b?b?b").exec("abbbbc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T10.js>
   */
  @Test
  public function S15_10_2_7_A5_T10() {
    var expectedMatch:Match = new Match("123az789", 3, ["az"]);
    var actualMatch:Match = new RegExp("ab?c?d?x?y?z").exec("123az789");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T11.js>
   */
  @Test
  public function S15_10_2_7_A5_T11() {
    var expectedMatch:Match = new Match("?????", 0, ["?????"]);
    var actualMatch:Match = new RegExp("\\??\\??\\??\\??\\??").exec("?????");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A5_T12.js>
   */
  @Test
  public function S15_10_2_7_A5_T12() {
    var expectedMatch:Match = new Match("test", 0, ["test"]);
    var actualMatch:Match = new RegExp(".?.?.?.?.?.?.?").exec("test");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A6_T1.js>
   */
  @Test
  public function S15_10_2_7_A6_T1() {
    var expectedMatch:Match = new Match("aaabbbbcccddeeeefffff", 3, ["bbbbc"]);
    var actualMatch:Match = new RegExp("b{2,}c").exec("aaabbbbcccddeeeefffff");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A6_T2.js>
   */
  @Test
  public function S15_10_2_7_A6_T2() {
    var actualMatch:Match = new RegExp("b{8,}c").exec("aaabbbbcccddeeeefffff");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A6_T3.js>
   */
  @Test
  public function S15_10_2_7_A6_T3() {
    var expectedMatch:Match = new Match("wqe456646dsff", 3, ["456646"]);
    var actualMatch:Match = new RegExp("\\d{1,}").exec("wqe456646dsff");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A6_T4.js>
   */
  @Test
  public function S15_10_2_7_A6_T4() {
    var expectedMatch:Match = new Match("123123", 0, ["123123","123"]);
    var actualMatch:Match = new RegExp("(123){1,}").exec("123123");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A6_T5.js>
   */
  @Test
  public function S15_10_2_7_A6_T5() {
    var expectedMatch:Match = new Match("123123x123", 0, ["123123x123","123"]);
    var actualMatch:Match = new RegExp("(123){1,}x\\1").exec("123123x123");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.7_A6_T6.js>
   */
  @Test
  public function S15_10_2_7_A6_T6() {
    var expectedMatch:Match = new Match("xxxxxxx", 0, ["xxxxxxx"]);
    var actualMatch:Match = new RegExp("x{1,2}x{1,}").exec("xxxxxxx");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A1_T1.js>
   */
  @Test
  public function S15_10_2_8_A1_T1() {
    var expectedMatch:Match = new Match("baaabac", 1, ["", "aaa"]);
    var actualMatch:Match = new RegExp("(?=(a+))").exec("baaabac");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A1_T2.js>
   */
  @Test
  public function S15_10_2_8_A1_T2() {
    var expectedMatch:Match = new Match("baaabac", 3, ["aba", "a"]);
    var actualMatch:Match = new RegExp("(?=(a+))a*b\\1").exec("baaabac");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A1_T3.js>
   */
  @Test
  public function S15_10_2_8_A1_T3() {
    var expectedMatch:Match = new Match("just Javascript: the way af jedi", 5, ["Javascript", "script"]);
    var actualMatch:Match = new RegExp("[Jj]ava([Ss]cript)?(?=\\:)").exec("just Javascript: the way af jedi");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A1_T4.js>
   */
  @Test
  public function S15_10_2_8_A1_T4() {
    var expectedMatch:Match = new Match("taste of java: the cookbook ", 9, ["java", null]);
    var actualMatch:Match = new RegExp("[Jj]ava([Ss]cript)?(?=\\:)").exec("taste of java: the cookbook ");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A1_T5.js>
   */
  @Test
  public function S15_10_2_8_A1_T5() {
    var actualMatch:Match = new RegExp("[Jj]ava([Ss]cript)?(?=\\:)").exec("rhino is JavaScript engine");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T1.js>
   */
  @Test
  public function S15_10_2_8_A2_T1() {
    var expectedMatch:Match = new Match("baaabaac", 0, ["baaabaac", "ba", null, "abaac"]);
    var actualMatch:Match = new RegExp("(.*?)a(?!(a+)b\\2c)\\2(.*)").exec("baaabaac");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T2.js>
   */
  @Test
  public function S15_10_2_8_A2_T2() {
    var expectedMatch:Match = new Match("using of JavaBeans technology", 9, ["JavaBeans", "Beans"]);
    var actualMatch:Match = new RegExp("Java(?!Script)([A-Z]\\w*)").exec("using of JavaBeans technology");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T3.js>
   */
  @Test
  public function S15_10_2_8_A2_T3() {
    var actualMatch:Match = new RegExp("Java(?!Script)([A-Z]\\w*)").exec("using of Java language");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T4.js>
   */
  @Test
  public function S15_10_2_8_A2_T4() {
    var actualMatch:Match = new RegExp("Java(?!Script)([A-Z]\\w*)").exec("i'm a JavaScripter ");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T5.js>
   */
  @Test
  public function S15_10_2_8_A2_T5() {
    var expectedMatch:Match = new Match("JavaScr oops ipt ", 0, ["JavaScr", "Scr"]);
    var actualMatch:Match = new RegExp("Java(?!Script)([A-Z]\\w*)").exec("JavaScr oops ipt ");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T6.js>
   */
  @Test
  public function S15_10_2_8_A2_T6() {
    var expectedMatch:Match = new Match("ah.info", 2, [".", "."]);
    var actualMatch:Match = new RegExp("(\\.(?!com|org)|\\/)").exec("ah.info");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T7.js>
   */
  @Test
  public function S15_10_2_8_A2_T7() {
    var expectedMatch:Match = new Match("ah/info", 2, ["/", "/"]);
    var actualMatch:Match = new RegExp("(\\.(?!com|org)|\\/)").exec("ah/info");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T8.js>
   */
  @Test
  public function S15_10_2_8_A2_T8() {
    var actualMatch:Match = new RegExp("(\\.(?!com|org)|\\/)").exec("ah.com");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T9.js>
   */
  @Test
  public function S15_10_2_8_A2_T9() {
    var expectedMatch:Match = new Match("", 0, [""]);
    var actualMatch:Match = new RegExp("(?!a|b)|c").exec("");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T10.js>
   */
  @Test
  public function S15_10_2_8_A2_T10() {
    var expectedMatch:Match = new Match("bc", 1, [""]);
    var actualMatch:Match = new RegExp("(?!a|b)|c").exec("bc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A2_T11.js>
   */
  @Test
  public function S15_10_2_8_A2_T11() {
    var expectedMatch:Match = new Match("d", 0, [""]);
    var actualMatch:Match = new RegExp("(?!a|b)|c").exec("d");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T1.js>
   */
  @Test
  public function S15_10_2_8_A3_T1() {
    var expectedMatch:Match = new Match("Learning javaScript is funny, really", 9, ["javaScript is funny","javaScript","Script","funny"]);
    var actualMatch:Match = new RegExp("([Jj]ava([Ss]cript)?)\\sis\\s(fun\\w*)").exec("Learning javaScript is funny, really");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T2.js>
   */
  @Test
  public function S15_10_2_8_A3_T2() {
    var expectedMatch:Match = new Match("Developing with Java is fun, try it", 16, ["Java is fun","Java", null,"fun"]);
    var actualMatch:Match = new RegExp("([Jj]ava([Ss]cript)?)\\sis\\s(fun\\w*)").exec("Developing with Java is fun, try it");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T3.js>
   */
  @Test
  public function S15_10_2_8_A3_T3() {
    var actualMatch:Match = new RegExp("([Jj]ava([Ss]cript)?)\\sis\\s(fun\\w*)").exec("Developing with JavaScript is dangerous, do not try it without assistance");
    Assert.isNull(actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T4.js>
   */
  @Test
  public function S15_10_2_8_A3_T4() {
    var expectedMatch:Match = new Match("abc", 0, ["abc","abc"]);
    var actualMatch:Match = new RegExp("(abc)").exec("abc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T5.js>
   */
  @Test
  public function S15_10_2_8_A3_T5() {
    var expectedMatch:Match = new Match("abcdefg", 0, ["abcdefg","bc","ef"]);
    var actualMatch:Match = new RegExp("a(bc)d(ef)g").exec("abcdefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T6.js>
   */
  @Test
  public function S15_10_2_8_A3_T6() {
    var expectedMatch:Match = new Match("abcdefgh", 0, ["abcdefg","abc","defg"]);
    var actualMatch:Match = new RegExp("(.{3})(.{4})").exec("abcdefgh");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T7.js>
   */
  @Test
  public function S15_10_2_8_A3_T7() {
    var expectedMatch:Match = new Match("aabcdaabcd", 0, ["aabcdaa","aa"]);
    var actualMatch:Match = new RegExp("(aa)bcd\\1").exec("aabcdaabcd");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T8.js>
   */
  @Test
  public function S15_10_2_8_A3_T8() {
    var expectedMatch:Match = new Match("aabcdaabcd", 0, ["aabcdaa","aa"]);
    var actualMatch:Match = new RegExp("(aa).+\\1").exec("aabcdaabcd");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T9.js>
   */
  @Test
  public function S15_10_2_8_A3_T9() {
    var expectedMatch:Match = new Match("aabcdaabcd", 0, ["aabcdaa","aa"]);
    var actualMatch:Match = new RegExp("(.{2}).+\\1").exec("aabcdaabcd");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T10.js>
   */
  @Test
  public function S15_10_2_8_A3_T10() {
    var expectedMatch:Match = new Match("123456123456", 0, ["123456123456","123","456"]);
    var actualMatch:Match = new RegExp("(\\d{3})(\\d{3})\\1\\2").exec("123456123456");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T11.js>
   */
  @Test
  public function S15_10_2_8_A3_T11() {
    var expectedMatch:Match = new Match("abcdefgh", 0, ["abcdefg","bcdefg","de"]);
    var actualMatch:Match = new RegExp("a(..(..)..)").exec("abcdefgh");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T12.js>
   */
  @Test
  public function S15_10_2_8_A3_T12() {
    var expectedMatch:Match = new Match("xabcdefg", 1, ["abcdef","abc","bc","c","def","ef","f"]);
    var actualMatch:Match = new RegExp("(a(b(c)))(d(e(f)))").exec("xabcdefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T13.js>
   */
  @Test
  public function S15_10_2_8_A3_T13() {
    var expectedMatch:Match = new Match("xabcdefbcefg", 1, ["abcdefbcef","abc","bc","c","def","ef","f"]);
    var actualMatch:Match = new RegExp("(a(b(c)))(d(e(f)))\\2\\5").exec("xabcdefbcefg");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T14.js>
   */
  @Test
  public function S15_10_2_8_A3_T14() {
    var expectedMatch:Match = new Match("abcd", 0, ["abcd",""]);
    var actualMatch:Match = new RegExp("a(.?)b\\1c\\1d\\1").exec("abcd");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T15.js>
   */
  @Test
  public function S15_10_2_8_A3_T15() {
    var patternSource:String = "hello";
    var expectedCaptures:Array<String> = ["hello"];
    for(i in 0...200) {
      patternSource = "(" + patternSource + ")";
      expectedCaptures.push("hello");
    }
    var expectedMatch:Match = new Match("hello", 0, expectedCaptures);
    var actualMatch:Match = new RegExp(patternSource).exec("hello");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T16.js>
   */
  @Test
  public function S15_10_2_8_A3_T16() {
    var patternSource:String = "hello";
    for(i in 0...200) {
      patternSource = "(?:" + patternSource + ")";
    }
    var expectedMatch:Match = new Match("hello", 0, ["hello"]);
    var actualMatch:Match = new RegExp(patternSource).exec("hello");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T17.js>
   */
  @Test
  public function S15_10_2_8_A3_T17() {
    var input:String = "<html>\n<body onXXX=\"alert(event.type);\">\n<p>Kibology for all</p>\n<p>All for Kibology</p>\n</body>\n</html>";
    var expectedMatch:Match = new Match(input, 7, ["<body onXXX=\"alert(event.type);\">\n<p>Kibology for all</p>\n<p>All for Kibology</p>\n</body>", "\n<p>Kibology for all</p>\n<p>All for Kibology</p>\n", "<p>All for Kibology</p>\n"]);
    var actualMatch:Match = new RegExp("<body.*>((.*\\n?)*?)<\\/body>", "i").exec(input);
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T18.js>
   */
  @Ignore("Requires support for `replace`")
  @Test
  public function S15_10_2_8_A3_T18() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T19.js>
   */
  @Test
  public function S15_10_2_8_A3_T19() {
    var expectedMatch:Match = new Match("Course_Creator = Test", 0, ["Course_Creator = Test","Course_Creator", null]);
    var actualMatch:Match = new RegExp("([\\S]+([ \\t]+[\\S]+)*)[ \\t]*=[ \\t]*[\\S]+").exec("Course_Creator = Test");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T20.js>
   */
  @Test
  public function S15_10_2_8_A3_T20() {
    var expectedMatch:Match = new Match("AAA", 0, ["AAA","A","AA"]);
    var actualMatch:Match = new RegExp("^(A)?(A.*)$").exec("AAA");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T21.js>
   */
  @Test
  public function S15_10_2_8_A3_T21() {
    var expectedMatch:Match = new Match("AA", 0, ["AA","A","A"]);
    var actualMatch:Match = new RegExp("^(A)?(A.*)$").exec("AA");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T22.js>
   */
  @Test
  public function S15_10_2_8_A3_T22() {
    var expectedMatch:Match = new Match("A", 0, ["A", null,"A"]);
    var actualMatch:Match = new RegExp("^(A)?(A.*)$").exec("A");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T23.js>
   */
  @Test
  public function S15_10_2_8_A3_T23() {
    var expectedMatch:Match = new Match("zxcasd;fl\\  ^AAAaaAAaaaf;lrlrzs", 13, ["AAAaaAAaaaf;lrlrzs","A","AAaaAAaaaf;lrlrzs"]);
    var actualMatch:Match = new RegExp("(A)?(A.*)").exec("zxcasd;fl\\  ^AAAaaAAaaaf;lrlrzs");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T24.js>
   */
  @Test
  public function S15_10_2_8_A3_T24() {
    var expectedMatch:Match = new Match("zxcasd;fl\\  ^AAaaAAaaaf;lrlrzs", 13, ["AAaaAAaaaf;lrlrzs","A","AaaAAaaaf;lrlrzs"]);
    var actualMatch:Match = new RegExp("(A)?(A.*)").exec("zxcasd;fl\\  ^AAaaAAaaaf;lrlrzs");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T25.js>
   */
  @Test
  public function S15_10_2_8_A3_T25() {
    var expectedMatch:Match = new Match("zxcasd;fl\\  ^AaaAAaaaf;lrlrzs", 13, ["AaaAAaaaf;lrlrzs", null,"AaaAAaaaf;lrlrzs"]);
    var actualMatch:Match = new RegExp("(A)?(A.*)").exec("zxcasd;fl\\  ^AaaAAaaaf;lrlrzs");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T26.js>
   */
  @Test
  public function S15_10_2_8_A3_T26() {
    var expectedMatch:Match = new Match("a", 0, ["a", null]);
    var actualMatch:Match = new RegExp("(a)?a").exec("a");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T27.js>
   */
  @Test
  public function S15_10_2_8_A3_T27() {
    var expectedMatch:Match = new Match("a", 0, ["a", null]);
    var actualMatch:Match = new RegExp("a|(b)").exec("a");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T28.js>
   */
  @Test
  public function S15_10_2_8_A3_T28() {
    var expectedMatch:Match = new Match("a", 0, ["a", null, "a"]);
    var actualMatch:Match = new RegExp("(a)?(a)").exec("a");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T29.js>
   */
  @Test
  public function S15_10_2_8_A3_T29() {
    var expectedMatch:Match = new Match("a", 0, ["a", null]);
    var actualMatch:Match = new RegExp("^([a-z]+)*[a-z]$").exec("a");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T30.js>
   */
  @Test
  public function S15_10_2_8_A3_T30() {
    var expectedMatch:Match = new Match("ab", 0, ["ab", "a"]);
    var actualMatch:Match = new RegExp("^([a-z]+)*[a-z]$").exec("ab");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T31.js>
   */
  @Test
  public function S15_10_2_8_A3_T31() {
    var expectedMatch:Match = new Match("abc", 0, ["abc", "ab"]);
    var actualMatch:Match = new RegExp("^([a-z]+)*[a-z]$").exec("abc");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T32.js>
   */
  @Test
  public function S15_10_2_8_A3_T32() {
    var expectedMatch:Match = new Match("www.netscape.com", 0, ["www.netscape.com", "netscape.", "netscap"]);
    var actualMatch:Match = new RegExp("^(([a-z]+)*[a-z]\\.)+[a-z]{2,}$").exec("www.netscape.com");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A3_T33.js>
   */
  @Test
  public function S15_10_2_8_A3_T33() {
    var expectedMatch:Match = new Match("www.netscape.com", 0, ["www.netscape.com", "netscape.", "netscap", "e"]);
    var actualMatch:Match = new RegExp("^(([a-z]+)*([a-z])\\.)+[a-z]{2,}$").exec("www.netscape.com");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T1.js>
   */
  @Test
  public function S15_10_2_8_A4_T1() {
    var expectedMatch:Match = new Match("abcde", 0, ["abcde"]);
    var actualMatch:Match = new RegExp("ab.de").exec("abcde");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T2.js>
   */
  @Test
  public function S15_10_2_8_A4_T2() {
    var expectedMatch:Match = new Match("line 1\nline 2", 0, ["line 1"]);
    var actualMatch:Match = new RegExp(".+").exec("line 1\nline 2");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T3.js>
   */
  @Test
  public function S15_10_2_8_A4_T3() {
    var expectedMatch:Match = new Match("this is a test", 0, ["this is a test"]);
    var actualMatch:Match = new RegExp(".*a.*").exec("this is a test");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T4.js>
   */
  @Test
  public function S15_10_2_8_A4_T4() {
    var expectedMatch:Match = new Match("this is a *&^%$# test", 0, ["this is a *&^%$# test"]);
    var actualMatch:Match = new RegExp(".+").exec("this is a *&^%$# test");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T5.js>
   */
  @Test
  public function S15_10_2_8_A4_T5() {
    var expectedMatch:Match = new Match("....", 0, ["...."]);
    var actualMatch:Match = new RegExp(".+").exec("....");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T6.js>
   */
  @Test
  public function S15_10_2_8_A4_T6() {
    var expectedMatch:Match = new Match("abcdefghijklmnopqrstuvwxyz", 0, ["abcdefghijklmnopqrstuvwxyz"]);
    var actualMatch:Match = new RegExp(".+").exec("abcdefghijklmnopqrstuvwxyz");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T7.js>
   */
  @Test
  public function S15_10_2_8_A4_T7() {
    var expectedMatch:Match = new Match("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0, ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]);
    var actualMatch:Match = new RegExp(".+").exec("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T8.js>
   */
  @Test
  public function S15_10_2_8_A4_T8() {
    var expectedMatch:Match = new Match("`1234567890-=~!@#$%^&*()_+", 0, ["`1234567890-=~!@#$%^&*()_+"]);
    var actualMatch:Match = new RegExp(".+").exec("`1234567890-=~!@#$%^&*()_+");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A4_T9.js>
   */
  @Test
  public function S15_10_2_8_A4_T9() {
    var expectedMatch:Match = new Match("|\\[{]};:\"',<>.?/", 0, ["|\\[{]};:\"',<>.?/"]);
    var actualMatch:Match = new RegExp(".+").exec("|\\[{]};:\"',<>.?/");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A5_T1.js>
   */
  @Test
  public function S15_10_2_8_A5_T1() {
    var expectedMatch:Match = new Match("ABC def ghi", 0, ["ABC"]);
    var actualMatch:Match = new RegExp("[a-z]+", "gi").exec("ABC def ghi");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.8_A5_T2.js>
   */
  @Test
  public function S15_10_2_8_A5_T2() {
    var expectedMatch:Match = new Match("ABC def ghi", 4, ["def"]);
    var actualMatch:Match = new RegExp("[a-z]+").exec("ABC def ghi");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.9_A1_T1.js>
   */
  @Test
  public function S15_10_2_9_A1_T1() {
    var expectedMatch:Match = new Match("do you listen the the band", 14, ["the the", "the"]);
    var actualMatch:Match = new RegExp("\\b(\\w+) \\1\\b").exec("do you listen the the band");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.9_A1_T2.js>
   */
  @Test
  public function S15_10_2_9_A1_T2() {
    var expectedMatch:Match = new Match("x09x12x01x01u00FFu00FFx04x04x23", 6, ["x01x01", "x01", null]);
    var actualMatch:Match = new RegExp("([xu]\\d{2}([A-H]{2})?)\\1").exec("x09x12x01x01u00FFu00FFx04x04x23");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.9_A1_T3.js>
   */
  @Test
  public function S15_10_2_9_A1_T3() {
    var expectedMatch:Match = new Match("x09x12x01x05u00FFu00FFx04x04x23", 12, ["u00FFu00FF", "u00FF", "FF"]);
    var actualMatch:Match = new RegExp("([xu]\\d{2}([A-H]{2})?)\\1").exec("x09x12x01x05u00FFu00FFx04x04x23");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  // There is no S15_10_2_9_A1_T4

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2.9_A1_T5.js>
   */
  @Test
  public function S15_10_2_9_A1_T5() {
    var expectedMatch:Match = new Match("baaac", 0, ["b", ""]);
    var actualMatch:Match = new RegExp("(a*)b\\1+").exec("baaac");
    Test262Test.assertAreEqualMatches(expectedMatch, actualMatch);
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.2_A1_T1.js>
   */
  @Ignore("Currently times out due to the quantifiers") // TODO: Improve the engine so this test passes
  @Test
  public function S15_10_2_A1_T1() {
    // REX/Javascript 1.0
    // Robert D. Cameron "REX: XML Shallow Parsing with Regular Expressions",
    // Technical Report TR 1998-17, School of Computing Science, Simon Fraser
    // University, November, 1998.
    // Copyright (c) 1998, Robert D. Cameron.
    // The following code may be freely used and distributed provided that
    // this copyright and citation notice remains intact and that modifications
    // or additions are clearly identified.
    var TextSE = "[^<]+";
    var UntilHyphen = "[^-]*-";
    var Until2Hyphens = UntilHyphen + "([^-]" + UntilHyphen + ")*-";
    var CommentCE = Until2Hyphens + ">?";
    var UntilRSBs = "[^\\]]*\\]([^\\]]+\\])*\\]+";
    var CDATA_CE = UntilRSBs + "([^\\]>]" + UntilRSBs + ")*>";
    var S = "[ \\n\\t\\r]+";
    var NameStrt = "[A-Za-z_:]|[^\\x00-\\x7F]";
    var NameChar = "[A-Za-z0-9_:.-]|[^\\x00-\\x7F]";
    var Name = "(" + NameStrt + ")(" + NameChar + ")*";
    var QuoteSE = "\"[^\"]" + "*" + "\"" + "|'[^']*'";
    var DT_IdentSE = S + Name + "(" + S + "(" + Name + "|" + QuoteSE + "))*";
    var MarkupDeclCE = "([^\\]\"'><]+|" + QuoteSE + ")*>";
    var S1 = "[\\n\\r\\t ]";
    var UntilQMs = "[^?]*\\?+";
    var PI_Tail = "\\?>|" + S1 + UntilQMs + "([^>?]" + UntilQMs + ")*>";
    var DT_ItemSE = "<(!(--" + Until2Hyphens + ">|[^-]" + MarkupDeclCE + ")|\\?" + Name + "(" + PI_Tail + "))|%" + Name + ";|" + S;
    var DocTypeCE = DT_IdentSE + "(" + S + ")?(\\[(" + DT_ItemSE + ")*\\](" + S + ")?)?>?";
    var DeclCE = "--(" + CommentCE + ")?|\\[CDATA\\[(" + CDATA_CE + ")?|DOCTYPE(" + DocTypeCE + ")?";
    var PI_CE = Name + "(" + PI_Tail + ")?";
    var EndTagCE = Name + "(" + S + ")?>?";
    var AttValSE = "\"[^<\"]" + "*" + "\"" + "|'[^<']*'";
    var ElemTagCE = Name + "(" + S + Name + "(" + S + ")?=(" + S + ")?(" + AttValSE + "))*(" + S + ")?/?>?";
    var MarkupSPE = "<(!(" + DeclCE + ")?|\\?(" + PI_CE + ")?|/(" + EndTagCE + ")?|(" + ElemTagCE + ")?)";
    var XML_SPE = TextSE + "|" + MarkupSPE;

    var patterns = [TextSE,UntilHyphen,Until2Hyphens,CommentCE,UntilRSBs,CDATA_CE,S,NameStrt, NameChar, Name, QuoteSE, DT_IdentSE, MarkupDeclCE, S1,UntilQMs, PI_Tail, DT_ItemSE, DocTypeCE, DeclCE, PI_CE, EndTagCE, AttValSE, ElemTagCE, MarkupSPE, XML_SPE];

    var input:String = ""
    + "<html xmlns=\"http://www.w3.org/1999/xhtml\"\n"
    + "      xmlns:xlink=\"http://www.w3.org/XML/XLink/0.9\">\n"
    + "  <head><title>Three Namespaces</title></head>\n"
    + "  <body>\n"
    + "    <h1 align=\"center\">An Ellipse and a Rectangle</h1>\n"
    + "    <svg xmlns=\"http://www.w3.org/Graphics/SVG/SVG-19991203.dtd\"\n"
    + "         width=\"12cm\" height=\"10cm\">\n"
    + "      <ellipse rx=\"110\" ry=\"130\" />\n"
    + "      <rect x=\"4cm\" y=\"1cm\" width=\"3cm\" height=\"6cm\" />\n"
    + "    </svg>\n"
    + "    <p xlink:type=\"simple\" xlink:href=\"ellipses.html\">\n"
    + "      More about ellipses\n"
    + "    </p>\n"
    + "    <p xlink:type=\"simple\" xlink:href=\"rectangles.html\">\n"
    + "      More about rectangles\n"
    + "    </p>\n"
    + "    <hr/>\n"
    + "    <p>Last Modified February 13, 2000</p>\n"
    + "  </body>\n"
    + "</html>";

    for(pattern in patterns) {
      new RegExp(pattern).test(input);  // Simply do not throw
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A1_T1.js>
   */
  @Ignore("ECMAScript-specific type conversion")
  @Test
  public function S15_10_3_1_A1_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A1_T2.js>
   */
  @Ignore("ECMAScript-specific type conversion")
  @Test
  public function S15_10_3_1_A1_T2() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A1_T3.js>
   */
  @Ignore("ECMAScript-specific type conversion")
  @Test
  public function S15_10_3_1_A1_T3() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A1_T4.js>
   */
  @Ignore("ECMAScript-specific type conversion")
  @Test
  public function S15_10_3_1_A1_T4() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A1_T5.js>
   */
  @Ignore("ECMAScript-specific type conversion")
  @Test
  public function S15_10_3_1_A1_T5() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A2_T1.js>
   */
  @Test
  public function S15_10_3_1_A2_T1() {
    try {
      var re = new RegExp("\\d", "1");
      Assert.fail("Expected RegExpSyntaxError");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A2_T2.js>
   */
  @Test
  public function S15_10_3_1_A2_T2() {
    try {
      var re = new RegExp("[a-b]?", cast(1));
      Assert.fail("Expected RegExpSyntaxError");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A3_T1.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_3_1_A3_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.3.1_A3_T2.js>
   */
  @Ignore("ECMAScript-specific construction from a \"stringifyable\" object")
  @Test
  public function S15_10_3_1_A3_T2() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.4.1_A1_T1.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_4_1_A1_T1() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.4.1_A1_T2.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_4_1_A1_T2() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.4.1_A1_T3.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_4_1_A1_T3() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.4.1_A1_T4.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_4_1_A1_T4() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.4.1_A1_T5.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_4_1_A1_T5() {
  }

  /**
   * @see <https://github.com/tc39/test262/blob/master/test/built-ins/RegExp/S15.10.4.1_A2_T1.js>
   */
  @Ignore("ECMAScript-specific construction from other RegExp")
  @Test
  public function S15_10_4_1_A2_T1() {
  }

  // TODO: constructor options
}
