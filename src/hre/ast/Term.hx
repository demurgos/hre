package hre.ast;

import hre.ast.Assertion in AssertionNode;

enum Term {
  Assertion(assertion:AssertionNode);
  Atom(atom:Atom);
  QuantifiedAtom(atom:Atom, quantifier:Quantifier, capturesStartIndex:Int, capturesEndIndex:Int);
}
