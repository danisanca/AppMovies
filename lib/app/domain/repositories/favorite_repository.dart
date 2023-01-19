
import 'package:app_movies/app/domain/erros.dart';
import 'package:dartz/dartz.dart';
import '../entities/movies_details_entity.dart';
import '../entities/movies_entity.dart';

abstract class FavoritesRepository {

  Future<Either<Failure,bool>> setFavorite(MovieDetailsEntity movie);
  Future<Either<Failure,List<MovieDetailsEntity>>> getFavorites();
  Future<Either<Failure,MovieDetailsEntity?>> getFavoriteMovieById(int id);
  Future<Either<Failure,bool>> deleteFavoriteById(int id);

}