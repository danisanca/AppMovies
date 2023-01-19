import 'package:dartz/dartz.dart';

import '../entities/movies_entity.dart';

abstract class GetMoviesRepository {
  Future<Either<Exception, MovieEntity>> call();
}