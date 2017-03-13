package hre;

import hre.ast.Alternative;
import hre.ast.Assertion in AssertionNode;
import hre.ast.Atom in AtomNode;
import hre.ast.Term in TermNode;
import hre.ast.Pattern;

class RegExpParserTest {
  @Test
  public function parse() {
    var source = "^ab$";
    var expected:Pattern = new Pattern([
      new Alternative([
        TermNode.Assertion(AssertionNode.StartOfText),
        TermNode.Atom(AtomNode.Literal("a")),
        TermNode.Atom(AtomNode.Literal("b")),
        TermNode.Assertion(AssertionNode.EndOfText)
      ])
    ], 0);
    var actual:Pattern = RegExpParser.parse(source);
    AssertPattern.areEqualPatterns(expected, actual);
  }

  @Test
  public function emptyQuantifierBlock() {
    var source:String;
    // TODO: syntax error ?
    source = "a{";
    var expected:Pattern = new Pattern([
      new Alternative([
        TermNode.Atom(AtomNode.Literal("a")),
        TermNode.Atom(AtomNode.Literal("{"))
      ])
    ], 0);
    var actual:Pattern = RegExpParser.parse(source);
    AssertPattern.areEqualPatterns(expected, actual);
    // source = "^a{,}$"; // Matches "a{,}" exactly
    // source = "^a{2,b}$"; // Matches "a{2,b}" exactly
  }

  @Test
  public function isolatedQuantifier() {
    var source:String;
    source = "+"; // Should error
    source = "\\b+"; // Should error
    source = "$+"; // Should error
    source = "(?=)+"; // Valid
    source = "(?!)+"; // Valid
  }

  @Test
  public function falseExpressions() {
    var source:String;
    source = "(?!)"; // Never match
    source = "[]"; // Never match (or maybe matches "\x00" ?)
    source = "$."; // Never match
  }

  @Test
  public function trueExpressions() {
    var source:String;
    source = ""; // Always match
    source = "(?=)"; // Always match
  }

  @Test
  public function coreVsBrowserAdditions() {
    var source:String;
    source = "}"; // Should error according to the spec (but works on Firefox and matches "}")
    source = "a(?=b){2}"; // Should error according to the spec (but works on Firefox and matches "ab")
    source = "\\xa"; // Should error according to the spec (but works on Firefox and matches "xa")
    source = "\\x"; // Should error according to the spec (but works on Firefox, I don't know what it matches)
  }
}
