package hre.ast;

enum Atom {
  AnyCharacter;
  Decimal;
  NotDecimal;
  Separator;
  NotSeparator;
  Word;
  NotWord;
  // captureId: id -> 1-based
  Backreference(captureId:Int);
  Literal(literal:String);
  Class(characterClass:CharacterClass);
  // captureIndex: index -> 0-based
  CaptureGroup(disjunction:Disjunction, captureIndex:Int);
  SimpleGroup(disjunction:Disjunction);
}
