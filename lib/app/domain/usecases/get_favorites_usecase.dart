import 'package:dartz/dartz.dart';

import '../entities/movies_details_entity.dart';
import '../erros.dart';

abstract class GetFavoritesUseCase {
  Future<Either<Failure,List<MovieDetailsEntity>>> call();
  
}