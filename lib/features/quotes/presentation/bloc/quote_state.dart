import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

@immutable
abstract class QuoteState extends Equatable {
  QuoteState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends QuoteState {}

class Loading extends QuoteState {}

class Loaded extends QuoteState {
  final Quote quote;

  Loaded({@required this.quote}) : super([quote]);
}

class Error extends QuoteState {
  final String message;

  Error({@required this.message}) : super([message]);
}
