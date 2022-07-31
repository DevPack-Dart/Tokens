import "package:common_extensions/src/libpack/collections.dart" show QueueList;
import "package:vignette_charcode/chars.dart";


class Token extends QueueList<Char>{
  Token(List<Char> ru): super(ru);
  Token.from(String str): Token(str.toChars());
}
