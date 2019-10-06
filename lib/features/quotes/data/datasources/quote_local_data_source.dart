import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import '../models/quote_model.dart';

abstract class QuoteLocalDataSource {
  Future<QuoteModel> getRandomQuote();
}

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  String filePath;

  QuoteLocalDataSourceImpl(this.filePath);

  @override
  Future<QuoteModel> getRandomQuote() async {
    int index = Random().nextInt(3000);
    String rawjson = await rootBundle.loadString(filePath);
    var quoteList = json.decode(rawjson);
    QuoteModel quote = QuoteModel.fromJson(quoteList[index]);

    return Future.value(quote);
  }
}
