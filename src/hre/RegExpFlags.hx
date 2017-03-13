package hre;

class RegExpFlags {
  public var global:Bool;
  public var ignoreCase:Bool;
  public var multiline:Bool;
  public var unicode:Bool;
  public var sticky:Bool;

  public function new(global:Bool, ignoreCase:Bool, multiline:Bool, sticky:Bool) {
    this.global = global;
    this.ignoreCase = ignoreCase;
    this.multiline = multiline;
    this.unicode = true;
    this.sticky = sticky;
  }
}
