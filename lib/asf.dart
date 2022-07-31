abstract class ASFBase{
  StringLines toNodeTree();
}
mixin ASFWithChildren on ASFBase{
  covariant List<ASFElement> _children = <ASFElement>[];
  void push(covariant ASFElement elm, [int loc = -1]){
    this._children.insert(elm, loc);
  }
}
///doc 
abstract class ASFRoot extends ASFBase with ASFWithChildren{
  ASFRoot([covariant List<ASFElement>? children]): children == null ? this._children = <ASFElement>[] ; this._children = children;
  @override
  StringLines toNodeTree(){}
  @override
  String toString(){}
}
abstract class ASFElement extends ASFBase{}
abstract class ASFNode extends ASFElement with ASFWithChildren{
}
abstract class ASFLeafMeta{}
abstract class ASFLeaf<M extends ASFLeafMeta> extends ASFElement{
  final M _meta;
  final List<Char> _symbol;
  ASFLeaf(this.symbol);
  @override
  StringLines toNodeTree(){}
  @override
  String toString(){}
}
typedef ASFOperation ASFResult Function(ASFBase) = ;
class ASFOperations{
  ASFOperation get push => (ASFWithChildren asf){
    asf.push()
  }
    operator +()
}