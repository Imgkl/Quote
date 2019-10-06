import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuoteEvent extends Equatable {
  QuoteEvent([List props = const <dynamic>[]]) : super(props);
}

class GetRandomQuoteEvent extends QuoteEvent {
  GetRandomQuoteEvent() : super([]);
}
