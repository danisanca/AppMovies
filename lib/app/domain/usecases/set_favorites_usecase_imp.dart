import 'package:app_movies/app/domain/repositories/favorite_repository.dart';
import 'package:app_movies/app/domain/usecases/set_favorites_usercase.dart';
import 'package:dartz/dartz.dart';

import '../entities/movies_details_entity.dart';
import '../erros.dart';

class SetFavoritesUseCaseImp implements SetFavoritesUseCase {
  final FavoritesRepository _favoritesRepository;

  SetFavoritesUseCaseImp(this._favoritesRepository);

  @override
  Future<Either<Failure, bool>> call(MovieDetailsEntity movie) async {
    return await _favoritesRepository.setFavorite(movie);
  }
}
