import 'dart:convert';
import 'package:app_movies/app/infra/dtos/movies_dto.dart';
import '../../../domain/entities/movies_entity.dart';
import '../get_movies_datasource.dart';
import 'get_movies_datasource_decorator.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class GetMoviesLocalDataSourceDecoratorImp
    extends GetMoviesDataSourceDecorator {
  GetMoviesLocalDataSourceDecoratorImp(GetMoviesDataSource getMoviesDataSource)
      : super(getMoviesDataSource);

  @override
  Future<MovieEntity> call() async {
    try {
      final result = await super();
      _saveInCache(result);
      return result;
    } catch (e) {
      return _getInCache();
    }

  }

  _saveInCache(MovieEntity movies) async {
    var prefs = await SharedPreferences.getInstance();
    String jsonMovies = jsonEncode(movies.toJson());
    prefs.setString('movies_cache', jsonMovies);
  }

  Future<MovieEntity> _getInCache() async {
    var prefs = await SharedPreferences.getInstance();
    var moviesJsonString = prefs.getString('movies_cache')!;
    var json = jsonDecode(moviesJsonString);
    var movies = MovieDto.fromJson(json);
    return movies;
  }
}
