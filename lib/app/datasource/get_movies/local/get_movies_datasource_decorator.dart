import 'package:dartz/dartz.dart';

import '../../../domain/entities/movies_entity.dart';
import '../get_movies_datasource.dart';

class GetMoviesDataSourceDecorator implements GetMoviesDataSource {
  final GetMoviesDataSource _getMoviesDataSource;
  GetMoviesDataSourceDecorator(this._getMoviesDataSource);

  @override
  Future<MovieEntity> call() => _getMoviesDataSource();
}