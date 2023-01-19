

import 'package:app_movies/app/domain/usecases/get_movies_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/get_movies_repository.dart';
import '../entities/movies_entity.dart';

class GetMoviesUseCaseImp implements GetMoviesUseCase {
  final GetMoviesRepository _getMoviesRepository;
  GetMoviesUseCaseImp(this._getMoviesRepository);

  @override
  Future<Either<Exception, MovieEntity>> call() async {
    return await _getMoviesRepository();
  }
}