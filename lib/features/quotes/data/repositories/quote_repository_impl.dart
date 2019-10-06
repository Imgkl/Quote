import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_local_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteLocalDataSource localDataSource;

  QuoteRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    try {
      final quote = await localDataSource.getRandomQuote();
      return Right(quote);
    } on Exception {
      return Left(LocalFailure());
    }
  }
}
