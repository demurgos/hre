package hre.ast;

/**
 * http://www.ecma-international.org/ecma-262/7.0/index.html#prod-Alternative
 */
class Alternative {
  public var terms:Array<Term>;

  public function new(expressions:Array<Term>) {
    this.terms = expressions;
  }
}
