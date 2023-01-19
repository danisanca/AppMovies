import 'package:app_movies/app/domain/entities/movies_details_entity.dart';

abstract class FavoriteDatasource {
  Future<bool> setFavorite(MovieDetailsEntity movie);
  Future<List<MovieDetailsEntity>> getFavorites();
  Future<MovieDetailsEntity?> getFavoriteMovieById(int id);
  Future<bool> deleteFavoriteById(int id);
}
