import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Quote extends Equatable {
  final String quote;
  final String author;
  final List<String> tags;
  final String category;

  Quote(
      {@required this.quote,
      @required this.author,
      @required this.tags,
      @required this.category})
      : super([quote, author, tags, category]);
}
