import 'package:meta/meta.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

class QuoteModel extends Quote {
  final String quote;
  final String author;
  final List<String> tags;
  final String category;

  QuoteModel(
      {@required this.quote,
      @required this.author,
      @required this.tags,
      @required this.category});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    var tagsFromJson = json['Tags'];
    List<String> tags = new List<String>.from(tagsFromJson);
    return QuoteModel(
        quote: json['Quote'],
        author: json['Author'],
        tags: tags,
        category: json['Category']);
  }
  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'author': author,
      'tags': tags,
      'category': category
    };
  }
}
