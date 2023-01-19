// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_movies/app/datasource/favorite/favorite_datasource.dart';
import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/infra/dtos/movies_details_dto.dart';
import 'package:app_movies/app/infra/provider/favorite.dart';

class FavoriteDatasourceLocalImp implements FavoriteDatasource {
  final _provider = FavoriteProvider();

  FavoriteDatasourceLocalImp() {
    _provider.open("db");
  }

  @override
  Future<List<MovieDetailsEntity>> getFavorites() async {
    final favoritesDb = await _provider.getFavorites();
    return favoritesDb
        .map((e) => MovieDetailsDto.fromJson(e.toMap()..['id'] = e.movieId))
        .toList();
  }

  @override
  Future<bool> setFavorite(MovieDetailsEntity movie) async {
    await _provider.insert(MovieDetailsDto.fromObjectToMap(movie));
    return true;
  }

  @override
  Future<bool> deleteFavoriteById(int id) async {
    await _provider.delete(id);
    return true;
  }

  @override
  Future<MovieDetailsEntity?> getFavoriteMovieById(int id) async {
    final movieFavorite = await _provider.getFavoriteByMovieId(id);
    return MovieDetailsDto.fromJson(movieFavorite!.toMap());
  }
}
