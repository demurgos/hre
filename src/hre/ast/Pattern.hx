package hre.ast;

/**
 * http://www.ecma-international.org/ecma-262/7.0/index.html#prod-Pattern
 */
class Pattern extends Disjunction {
  public var captures:Int;

  public function new(alternatives:Array<Alternative>, captures:Int) {
    super(alternatives);
    this.captures = captures;
  }
}
