import 'package:dartz/dartz.dart';

import '../../domain/entities/movies_entity.dart';


abstract class GetMoviesDataSource {
  Future<MovieEntity> call();
}