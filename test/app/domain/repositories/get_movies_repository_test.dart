import 'package:app_movies/app/datasource/get_movies/get_movies_datasource.dart';
import 'package:app_movies/app/domain/entities/movies_entity.dart';
import 'package:app_movies/app/domain/repositories/get_moveis_repository_imp.dart';
import 'package:app_movies/app/domain/repositories/get_movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMoviesDataSourceMock extends Mock implements GetMoviesDataSource {}

void main() {
  late GetMoviesRepositoryImp getMoviesRepositoryImp;
  late GetMoviesDataSource getMoviesDataSource;
  late MovieEntity movieEntity;

  setUp(() {
    getMoviesDataSource = GetMoviesDataSourceMock();
    getMoviesRepositoryImp = GetMoviesRepositoryImp(getMoviesDataSource);
    movieEntity = MovieEntity(
        averageRating: 0.0,
        backdropPath: "backdropPath",
        description: "description",
        id: 0,
        iso_3166_1: "iso_3166_1",
        iso_639_1: 'iso_639_1',
        name: "name",
        page: 0,
        posterPath: "posterPath",
        public: true,
        listMovies: [],
        revenue: 0,
        runtime: 0,
        sortBy: "sortBy",
        totalPages: 1,
        totalResults: 1);
  });

  group("[Domain] - GetMoviesRepository", () {
    test("Deve retornar sucesso", () async {
      when(() => getMoviesDataSource())
          .thenAnswer((invocation) async => movieEntity);

      final result = await getMoviesRepositoryImp();

      expect(result, isA<Right<Exception, MovieEntity>>());
    });
    test("Deve retornar um erro", () async {
      when(() => getMoviesDataSource()).thenThrow(Exception());

      final result = await getMoviesRepositoryImp();

      expect(result, isA<Left<Exception, MovieEntity>>());
    });
  });
}
