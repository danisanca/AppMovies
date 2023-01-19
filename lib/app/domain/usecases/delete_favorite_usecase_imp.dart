// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:app_movies/app/domain/erros.dart';
import 'package:app_movies/app/domain/usecases/delete_favorite_usecase.dart';

import '../repositories/favorite_repository.dart';

class DeleteFavoriteUseCaseImp implements DeleteFavoriteUseCase {
  final FavoritesRepository _favoritesRepository;

  DeleteFavoriteUseCaseImp(this._favoritesRepository);

  @override
  Future<Either<Failure, bool>> call(int id) async {
    return await _favoritesRepository.deleteFavoriteById(id);
  }
}
