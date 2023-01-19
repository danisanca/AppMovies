// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/domain/erros.dart';
import 'package:app_movies/app/domain/usecases/get_favorites_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/favorite_repository.dart';

class GetFavoritesUseCaseImp implements GetFavoritesUseCase {
  final FavoritesRepository _favoritesRepository;

  GetFavoritesUseCaseImp(this._favoritesRepository);

  @override
  Future<Either<Failure, List<MovieDetailsEntity>>> call() async {
    return await _favoritesRepository.getFavorites();
  }
}
