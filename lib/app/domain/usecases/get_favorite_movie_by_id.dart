
import 'package:dartz/dartz.dart';

import '../entities/movies_details_entity.dart';
import '../erros.dart';

abstract class GetFavoriteMovieByIdUseCase {
  Future<Either<Failure,MovieDetailsEntity?>> call(int id);
  
}