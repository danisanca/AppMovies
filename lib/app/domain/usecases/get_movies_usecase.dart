import 'package:dartz/dartz.dart';

import '../entities/movies_entity.dart';

abstract class GetMoviesUseCase {
  Future<Either<Exception, MovieEntity>> call();
}