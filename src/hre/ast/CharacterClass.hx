package hre.ast;

/**
 * http://www.ecma-international.org/ecma-262/7.0/index.html#prod-Disjunction
 */
class CharacterClass {
  public var inverted:Bool;
  public var ranges:Array<CharacterClassRange>;

  public function new(inverted:Bool, ranges:Array<CharacterClassRange>) {
    this.inverted = inverted;
    this.ranges = ranges;
  }
}
