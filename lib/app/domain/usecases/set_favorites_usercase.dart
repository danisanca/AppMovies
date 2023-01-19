
import 'package:dartz/dartz.dart';

import '../entities/movies_details_entity.dart';
import '../erros.dart';

abstract class SetFavoritesUseCase {
  Future<Either<Failure,bool>>  call(MovieDetailsEntity movie);
}