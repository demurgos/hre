package hre.ast;

/**
 * http://www.ecma-international.org/ecma-262/7.0/index.html#prod-Disjunction
 */
class Disjunction {
  public var alternatives:Array<Alternative>;

  public function new(alternatives:Array<Alternative>) {
    this.alternatives = alternatives;
  }
}
