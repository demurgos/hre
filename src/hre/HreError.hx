package hre;

/**
 * Base class for all the errors emitted by `hre`.
 */
class HreError {
  public var message(default, null):String;

  public function new(message:String) {
    this.message = message;
  }
}
