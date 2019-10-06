import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository repository;

  GetRandomQuote(this.repository);

  @override
  Future<Either<Failure, Quote>> call(NoParams params) async {
    return await repository.getRandomQuote();
  }
}
