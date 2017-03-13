package hre.ast;

enum Assertion {
  StartOfText;
  EndOfText;
  WordBoundary;
  NotWordBoundary;
  FollowedBy(disjunction:Disjunction);
  NotFollowedBy(disjunction:Disjunction);
}
