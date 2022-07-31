typedef MarOcc = MarkovianOccurrence;

///Context-dependent occurrence count of chars on some source text(s).
class MarkovianOccurrence implements Comparable<MarkovianOccurrence>{
  final Char symbol;
  final List<Char> context;
  int _count;
  MarkovianOccurrence(this.symbol,this.context): this._count = 0;
  void operator ++(){
    this._count++;
  }
  void get reset{
    this._count = 0;
  }
  int get count = this._count;
  MarkovianOccurrence countUp(){
    this++;
    return this;
  }
  MarkovianOccurrence resets(){
    this.reset;
    return this;
  }
  int compereTo(MarkovianOccurrence other, [bool byValue = false]){
    if(byValue){
      return this.count.compereTo(other.count);
    }else{
      if(this.symbol < other.symbol){
        return -1;
      }else if(this.symbol > other.symbol){
        return 1;
      }else{
        if(this.context.length < other.context.length){
          return -1;
        }else if(this.context.length > other.context.length){
          return 1;
        }else{
          for(int i = 0; i < this.context.length; i++){
            if(this.context[i] < other.context[i]){
              return -1;
            }else if(this.context[i] > other.context[i]){
              return 1;
            }
          }
          return 0;
        }
      }
    }
  }
}
extension MarkovianOccurrenceList on List<MarkovianOccurrence> {
  bool exists(Char symbol, List<Char> context) =>
    this.where((MarkovianOccurrence mo)=>mo.symbol == symbol && mo.context == context).isNotEmpty;
  int indexOn(Char symbol, List<Char> context) =>
    this.indexWhere((MarkovianOccurrence mo)=>mo.symbol == symbol && mo.context == context);
  void reset(Char symbol, List<Char> context) =>
    this.exists(symbol, context) ?
      this[this.indexOn(symbol, context)].reset :
      (){}();
  void init(Char symbol, List<Char> context)=>
    this.exists(symbol, context) ?
      this.reset(symbol, context) :
      this.add(MarkovianOccurrence(symbol, context));
  void addOn(Char symbol, List<Char> context) =>
    this.exists(symbol, context) ?
      (){}() :
      this.init(symbol, context);
  void countUp(Char symbol, List<Char> context) =>
    this.exists(symbol, context) ?
      this[this.indexOn(symbol, context)]++ :
      this.init(symbol, context);
}
class MarkovianOccurrenceScanner{
  static List<MarkovianOccurrence> scan(List<Char> from, int maxContext,[bool withSort = true]){
    if(maxContext < 0 || from.length - 1 < maxContext){
    }
    List<MarkovianOccurrence> res = <MarkovianOccurrence>[];
    for(){
      res.countUp();
    }
    if(withSort){
      return res.sorted();
    }else{
      return res;
    }
  }
}
extension MarkovianOccurrenceScanningS on String {
  List<MarkovianOccurrence> marOccScan() => MarkovianOccurrenceScanner.scan(this.toChars());
}
extension MarkovianOccurrenceScanningR on Runes {
  List<MarkovianOccurrence> marOccScan() => MarkovianOccurrenceScanner.scan(this.toChars());
}