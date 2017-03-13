package hre;

class Match {
  public var input:String;
  public var index:Int;
  public var groups:Array<String>;

  public function new(input:String, index:Int, groups:Array<String>) {
    this.input = input;
    this.index = index;
    this.groups = groups;
  }

  public function equals(other:Match) {
    if (other == null || this.input != other.input || this.index != other.index) {
      return false;
    }
    for (i in 0...this.groups.length) {
      if (this.groups[i] != other.groups[i]) {
        return false;
      }
    }
    return true;
  }

  public function toString() {
    return "Match(input=\"" + this.input + "\", index=" + this.index + ", groups=[" + this.groups.join(", ") + "])";
  }
}
