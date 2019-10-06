import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

import './bloc.dart';
import '../../domain/usecases/get_random_quote.dart';

const String LOCAL_FAILURE_MESSAGE = 'Local Storage Failure';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetRandomQuote getRandomQuote;

  QuoteBloc({
    @required GetRandomQuote random,
  })  : assert(random != null),
        getRandomQuote = random;

  @override
  QuoteState get initialState => Empty();

  @override
  Stream<QuoteState> mapEventToState(
    QuoteEvent event,
  ) async* {
    if (event is GetRandomQuoteEvent) {
      yield Loading();
      final failureOrQuote = await getRandomQuote(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrQuote);
    }
  }

  Stream<QuoteState> _eitherLoadedOrErrorState(
    Either<Failure, Quote> failureOrQuote,
  ) async* {
    yield failureOrQuote.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (quote) => Loaded(quote: quote),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case LocalFailure:
        return LOCAL_FAILURE_MESSAGE;

      default:
        return 'Unexpected error';
    }
  }
}
