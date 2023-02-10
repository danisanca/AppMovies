// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/domain/erros.dart';
import 'package:dartz/dartz.dart';

import 'package:app_movies/app/domain/repositories/favorite_repository.dart';

import '../../datasource/favorite/favorite_datasource.dart';

class FavoritesRepositoryImp implements FavoritesRepository {
  final FavoriteDatasource _favoriteDatasource;

  FavoritesRepositoryImp(this._favoriteDatasource);

  @override
  Future<Either<Failure, bool>> setFavorite(MovieDetailsEntity movie) async {
    try {
      return Right(await _favoriteDatasource.setFavorite(movie));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<MovieDetailsEntity>>> getFavorites() async {
    try {
      return Right(await _favoriteDatasource.getFavorites());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> deleteFavoriteById(int id) async {
    try {
      return Right(await _favoriteDatasource.deleteFavoriteById(id));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure());
    }
  }
  
  @override
  Future<Either<Failure, MovieDetailsEntity?>> getFavoriteMovieById(int id) async {
    try {
      return Right(await _favoriteDatasource.getFavoriteMovieById(id));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure());
    }
  }
}
