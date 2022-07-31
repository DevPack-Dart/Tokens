import "package:tokens/tokens.dart";
import "package:tokens/logger.dart";

typedef TokenCondition = bool Function(List<Char>);
class TokenLib{
  static TokenCondition startsWith(String str)=>(List<Char> target){
      List<Pair<Char>> comp = Pairs<Char>.from(target,str.toChars()).match((Char a, Char b)=>a==b);
    };
  static TokenCondition endsWith(String str)=>(List<chars> target){
      List<Pair<Char>> comp = Pairs<Char>.from(target,str.toChars()).reverse.match((Char a, Char b)=>a==b);
    };
  static TokenCondition cover(String start, String end)=>TokenLib.startsWith(start) & TokenLib.endsWith(end);
  static TokenCondition terminated(String terminal)=>TokenLib.cover(terminal, terminal);
  static TokenCondition any(List<TokenCondition> conditions)=>(List<Char> target){}
  static TokenCondition every(List<TokenCondition> conditions)=>(List<Char> target){}
  static TokenCondition reverse(TokenCondition condition)=>(List<Char> target){}
  static TokenCondition sequence(List<TokenCondition> conditions)=>(List<Char> target){}
}
extension TokenLibX on TokenCondition{
  TokenCondition over(TokenCondition Function(TokenCondition) overCondition)=>overCondition(this);
  TokenCondition trail(TokenCondition condition)=>(List<Char> target){}
  TokenCondition not()=>TokenLib.reversed(this);
  TokenCondition and(TokenCondition other)=>TokenLib.every([this, other]);
  TokenCondition or(TokenCondition other)=>TokenLib.any([this, other])
  TokenCondition xor(TokenCondition other)=>(List<Char> target){
      if(this.and(other)(target)){
        return false;
      }else{
        return this.or(other)(target);
      }
    };
  TokenCondition operator !()=>this.not()
  TokenCondition operator &(TokenCondition other)=>this.and(other);
  TokenCondition operator |(TokenCondition other)=>this.or(other);
  TokenCondition operator &&(TokenCondition other)=>this.and(other);
  TokenCondition operator ||(TokenCondition other)=>this.or(other);
  TokenCondition operator ^(TokenCondition other)=>this.xor(other);
  TokenCondition operator +(TokenCondition other)=>this.trail(other);
}
enum TokenScanResult{}
enum TokenHandleResult{}
typedef TokenHandler = TokenHandleResult Function(List<Char>);
class TokenScanner{
  Token token;
  final Token _tokenInitial;
  int _position;//cursor
  TokenScanTrace _log;
  TokenScanResult _result;
  TokenScanner(Token token):
    this.token = token,
    this._tokenInitial = token;
  factory TokenScanner.rewind(TokenScanState tss);
  TokenScanner.build(String str): this.token = Token.from(str);
  TokenScanner addAutoSkip(Char skipee){}
  TokenScanner addAutoSkips(List<Char> skipees){}
  TokenScanner removeAutoSkip(Char skipee){}
  TokenScanner removeAutoSkips(List<Char> skipees){}
  TokenScanner expect(TokenCondition condition, {required TokenHandler onSuc, TokenHandler onFail}){}
  TokenScanner skip(int count){}
  TokenScanner skipTil(TokenCondition condition){}
  TokenScanner loopTil(TokenCondition condition, {TokenHandler work}){}
  TokenScanner loop(int count){}
  TokenScanner loop(){}
  TokenScanResult finale(){}
  TokenScanState suspend()=>TokenScanState._build();
}
class TokenScanState{
  final Token _token;
  final Token _tokenInitial;
  int _position;
  TokenScanState._build();
}