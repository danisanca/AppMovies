import 'package:dartz/dartz.dart';

import 'package:app_movies/app/domain/erros.dart';

import 'package:app_movies/app/domain/entities/movies_details_entity.dart';

import '../repositories/favorite_repository.dart';
import 'get_favorite_movie_by_id.dart';

class GetFavoriteMovieByIdUseCaseImp implements GetFavoriteMovieByIdUseCase {

final FavoritesRepository _favoritesRepository;

  GetFavoriteMovieByIdUseCaseImp(this._favoritesRepository);

  @override
  Future<Either<Failure, MovieDetailsEntity?>> call(int id) async {
    return await _favoritesRepository.getFavoriteMovieById(id);
  }
 
  
}