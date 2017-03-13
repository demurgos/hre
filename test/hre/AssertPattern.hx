package hre;

import massive.munit.Assert;
import hre.ast.Alternative;
import hre.ast.Assertion in AssertionNode;
import hre.ast.Atom in AtomNode;
import hre.ast.CharacterClass in CharacterClassNode;
import hre.ast.Disjunction;
import hre.ast.Pattern;
import hre.ast.Quantifier;
import hre.ast.Term;
import hre.RegExpParser.RegExpSyntaxError;

class AssertPattern {
  /**
   * Asserts that a syntax error is thrown when attempting to compile a RegExp for the supplied pattern.
   */
  public static function throwsSyntaxError(source:String) {
    try {
      RegExpParser.parse(source);
      Assert.fail("Expected syntax error");
    } catch (err:Dynamic) {
      Assert.isTrue(Std.is(err, RegExpSyntaxError));
    }
  }

  /**
   * Asserts that the supplied pattern can be compiled without throwing a syntax error.
   */
  public static function doesNotThrowSyntaxError(source:String) {
    RegExpParser.parse(source);
  }

  public static function isPattern(val:Pattern):Void {
    AssertPattern.isDisjunction(val);
    Assert.isTrue(Std.is(val, Pattern));
  }

  public static function areEqualPatterns(expected:Pattern, actual:Pattern):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isPattern(expected);
    AssertPattern.isPattern(actual);
    Assert.areEqual(expected.captures, actual.captures);
    AssertPattern.areEqualDisjunctions(expected, actual);
  }

  public static function isDisjunction(val:Disjunction):Void {
    Assert.isTrue(Std.is(val, Disjunction));
    Assert.isTrue(Std.is(val.alternatives, Array));
  }

  public static function areEqualDisjunctions(expected:Disjunction, actual:Disjunction):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isDisjunction(expected);
    AssertPattern.isDisjunction(actual);
    Assert.areEqual(expected.alternatives.length, actual.alternatives.length);
    for (i in 0...expected.alternatives.length) {
      AssertPattern.areEqualAlternatives(expected.alternatives[i], actual.alternatives[i]);
    }
  }

  public static function isAlternative(val:Alternative):Void {
    Assert.isTrue(Std.is(val, Alternative));
    Assert.isTrue(Std.is(val.terms, Array));
  }

  public static function areEqualAlternatives(expected:Alternative, actual:Alternative):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isAlternative(expected);
    AssertPattern.isAlternative(actual);
    Assert.areEqual(expected.terms.length, actual.terms.length);
    for (i in 0...(expected.terms.length)) {
      AssertPattern.areEqualTerms(expected.terms[i], actual.terms[i]);
    }
  }

  public static function isTerm(val:Term):Void {
    Assert.isTrue(Std.is(val, Term));
    switch (val) {
      case Term.Assertion(assertion):
        Assert.isTrue(Std.is(assertion, AssertionNode));
      case Term.Atom(atom):
        Assert.isTrue(Std.is(atom, AtomNode));
      case Term.QuantifiedAtom(atom, quantifier, captureStart, captureEnd):
        Assert.isTrue(Std.is(atom, AtomNode));
        Assert.isTrue(Std.is(quantifier, Quantifier));
    }
  }

  public static function areEqualTerms(expected:Term, actual:Term):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isTerm(expected);
    AssertPattern.isTerm(actual);
    switch(expected) {
      case Term.Assertion(expectedAssertion):
        switch(actual) {
          case Term.Assertion(actualAssertion):
            AssertPattern.areEqualAssertions(expectedAssertion, actualAssertion);
          default:
            Assert.fail("Expected is Term, actual is " + Type.enumConstructor(actual));
        }
      case Term.Atom(expectedAtom):
        switch(actual) {
          case Term.Atom(actualAtom):
            AssertPattern.areEqualAtoms(expectedAtom, actualAtom);
          default:
            Assert.fail("Expected is Atom, actual is " + Type.enumConstructor(actual));
        }
      case Term.QuantifiedAtom(expectedAtom, expectedQuantifier, expectedCaptureStart, expectedCaptureEnd):
        switch(actual) {
          case Term.QuantifiedAtom(actualAtom, actualQuantifier, actualCaptureStart, actualCaptureEnd):
            Assert.areEqual(expectedCaptureStart, actualCaptureStart);
            Assert.areEqual(expectedCaptureEnd, actualCaptureEnd);
            AssertPattern.areEqualAtoms(expectedAtom, actualAtom);
            AssertPattern.areEqualQuantifiers(expectedQuantifier, actualQuantifier);
          default:
            Assert.fail("Expected is Atom, actual is " + Type.enumConstructor(actual));
        }
    }
  }

  public static function isAssertion(val:AssertionNode):Void {
    Assert.isTrue(Std.is(val, AssertionNode));
  }

  public static function areEqualAssertions(expected:AssertionNode, actual:AssertionNode):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isAssertion(expected);
    AssertPattern.isAssertion(actual);
    switch(expected) {
      case AssertionNode.FollowedBy(expectedDisjunction):
        switch(actual) {
          case AssertionNode.FollowedBy(actualDisjunction):
            AssertPattern.areEqualDisjunctions(expectedDisjunction, actualDisjunction);
          default:
            Assert.fail("Expected is FollowedBy, actual is " + Type.enumConstructor(actual));
        }
      case AssertionNode.NotFollowedBy(expectedDisjunction):
        switch(actual) {
          case AssertionNode.NotFollowedBy(actualDisjunction):
            AssertPattern.areEqualDisjunctions(expectedDisjunction, actualDisjunction);
          default:
            Assert.fail("Expected is NotFollowedBy, actual is " + Type.enumConstructor(actual));
        }
      default:
        Assert.areEqual(Type.enumConstructor(expected), Type.enumConstructor(actual));
    }
  }

  public static function isAtom(val:AtomNode):Void {
    Assert.isTrue(Std.is(val, AtomNode));
  }

  public static function areEqualAtoms(expected:AtomNode, actual:AtomNode):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isAtom(expected);
    AssertPattern.isAtom(actual);
    switch(expected) {
      case AtomNode.Literal(expectedLiteral):
        switch(actual) {
          case AtomNode.Literal(actualLiteral):
            Assert.areEqual(expectedLiteral, actualLiteral);
          default:
            Assert.fail("Expected is Literal, actual is " + Type.enumConstructor(actual));
        }
      case AtomNode.Class(expectedCharacterClass):
        switch(actual) {
          case AtomNode.Class(actualCharacterClass):
            AssertPattern.areEqualCharacterClasses(expectedCharacterClass, actualCharacterClass);
          default:
            Assert.fail("Expected is CharacterClass, actual is " + Type.enumConstructor(actual));
        }
      case AtomNode.CaptureGroup(expectedDisjunction, expectedCaptureIndex):
        switch(actual) {
          case AtomNode.CaptureGroup(actualDisjunction, actualCaptureIndex):
            AssertPattern.areEqualDisjunctions(expectedDisjunction, actualDisjunction);
            Assert.areEqual(expectedCaptureIndex, actualCaptureIndex);
          default:
            Assert.fail("Expected is CaptureGroup, actual is " + Type.enumConstructor(actual));
        }
      case AtomNode.SimpleGroup(expectedDisjunction):
        switch(actual) {
          case AtomNode.SimpleGroup(actualDisjunction):
            AssertPattern.areEqualDisjunctions(expectedDisjunction, actualDisjunction);
          default:
            Assert.fail("Expected is SimpleGroup, actual is " + Type.enumConstructor(actual));
        }
      default:
        Assert.areEqual(Type.enumConstructor(expected), Type.enumConstructor(actual));
    }
  }

  public static function isQuantifier(val:Quantifier):Void {
    Assert.isTrue(Std.is(val, Quantifier));
  }

  public static function areEqualQuantifiers(expected:Quantifier, actual:Quantifier):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
      return;
    }
    AssertPattern.isQuantifier(expected);
    AssertPattern.isQuantifier(actual);
    Assert.areEqual(expected.min, actual.min);
    Assert.areEqual(expected.max, actual.max);
    Assert.areEqual(expected.greedy, actual.greedy);
  }


  public static function isCharacterClass(val:CharacterClassNode):Void {
    Assert.isTrue(Std.is(val, CharacterClassNode));
    Assert.isTrue(Std.is(val.ranges, Array));
  }

  public static function areEqualCharacterClasses(expected:CharacterClassNode, actual:CharacterClassNode):Void {
    if (expected == null || actual == null) {
      Assert.areEqual(expected, actual);
    }
  }
}
