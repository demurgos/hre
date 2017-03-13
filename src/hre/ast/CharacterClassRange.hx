package hre.ast;

enum CharacterClassRange {
  Range(start:String, end:String);
  Simple(value:CharacterClassAtom);
}
