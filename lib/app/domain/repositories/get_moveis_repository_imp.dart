import 'package:dartz/dartz.dart';


import '../../datasource/get_movies/get_movies_datasource.dart';
import '../entities/movies_entity.dart';
import 'get_movies_repository.dart';


class GetMoviesRepositoryImp implements GetMoviesRepository {
  final GetMoviesDataSource _getMoviesDataSource;
  GetMoviesRepositoryImp(this._getMoviesDataSource);

  @override
  Future<Either<Exception, MovieEntity>> call() async {
    return await _getMoviesDataSource();
  }
}
