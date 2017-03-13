package hre.ast;

class Quantifier {
  public var min:Int;
  public var max:Int;
  public var greedy:Bool;

  public function new(min:Int, max:Int, greedy:Bool) {
    this.min = min;
    this.max = max;
    this.greedy = greedy;
  }
}
