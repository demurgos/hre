package hre;

#if !(flash8 || flash)
#error
#end

import hre.RegExp;

#if !flash8
import openfl.display.Sprite;
#end

class Main #if !flash8 extends Sprite #end {
  public static function run() {
    trace("hre-lib");
  }

  #if flash8

  public static function main() {
    Main.run();
  }
  #else

  public function new() {
    super();
    Main.run();
  }
  #end
}
