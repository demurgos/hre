package hre.ast;

enum CharacterClassAtom {
  Literal(value:String);
  Decimal;
  NotDecimal;
  Separator;
  NotSeparator;
  Word;
  NotWord;
}
