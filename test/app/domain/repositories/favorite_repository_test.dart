import 'package:app_movies/app/datasource/favorite/favorite_datasource.dart';
import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/domain/erros.dart';
import 'package:app_movies/app/domain/repositories/favorite_repository_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FavoriteDataSourceMock extends Mock implements FavoriteDatasource {}

void main() {
  late FavoritesRepositoryImp favoritesRepositoryImp;
  late FavoriteDatasource favoriteDatasource;
  late MovieDetailsEntity movieDetailsEntity;

  setUp(() {
    favoriteDatasource = FavoriteDataSourceMock();
    favoritesRepositoryImp = FavoritesRepositoryImp(favoriteDatasource);
    movieDetailsEntity = const MovieDetailsEntity(
        adult: false,
        backdropPath: "/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg",
        id: 634649,
        mediaType: "movie",
        originalLanguage: "en",
        originalTitle: "Spider-Man: No Way Home",
        overview:
            "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
        popularity: 444.452,
        posterPath: "/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg",
        releaseDate: "2021-12-15",
        title: "Spider-Man: No Way Home",
        video: false,
        voteAverage: 8,
        voteCount: 16031);
  });

  group("[Domain] - FavoriteRepository", () {
    group("[function] - SetFavorite", () {
      test("Deve retornar sucesso", () async {
        when(() => favoriteDatasource.setFavorite(movieDetailsEntity))
            .thenAnswer((invocation) async => true);

        final result =
            await favoritesRepositoryImp.setFavorite(movieDetailsEntity);

        expect(result, isA<Right<Failure, bool>>());
      });
      test("Deve retornar um erro", () async {
        when(() => favoriteDatasource.setFavorite(movieDetailsEntity))
            .thenThrow(Failure());

        final result =
            await favoritesRepositoryImp.setFavorite(movieDetailsEntity);

        expect(result, isA<Left<Exception, bool>>());
      });
    });
    group("[function] - GetFavorite", () {
      test("Deve retornar sucesso", () async {
        when(() => favoriteDatasource.getFavorites())
            .thenAnswer((invocation) async => [movieDetailsEntity]);

        final result = await favoritesRepositoryImp.getFavorites();

        expect(result, isA<Right<Failure, List<MovieDetailsEntity>>>());
      });
      test("Deve retornar um erro", () async {
        when(() => favoriteDatasource.getFavorites()).thenThrow(Failure());

        final result = await favoritesRepositoryImp.getFavorites();

        expect(result, isA<Left<Exception, List<MovieDetailsEntity>>>());
      });
    });
    group("[function] - DeleteFavorite", () {
      test("Deve retornar sucesso", () async {
        when(() => favoriteDatasource.deleteFavoriteById(movieDetailsEntity.id))
            .thenAnswer((invocation) async => true);

        final result = await favoritesRepositoryImp
            .deleteFavoriteById(movieDetailsEntity.id);

        expect(result, isA<Right<Failure, bool>>());
      });
      test("Deve retornar um erro", () async {
        when(() => favoriteDatasource.deleteFavoriteById(movieDetailsEntity.id))
            .thenThrow(Failure());

        final result = await favoritesRepositoryImp
            .deleteFavoriteById(movieDetailsEntity.id);

        expect(result, isA<Left<Exception, bool>>());
      });
    });
    group("[function] - GetFavoriteMovieById", () {
      test("Deve retornar sucesso", () async {
        when(() =>
                favoriteDatasource.getFavoriteMovieById(movieDetailsEntity.id))
            .thenAnswer((invocation) async => movieDetailsEntity);

        final result = await favoritesRepositoryImp
            .getFavoriteMovieById(movieDetailsEntity.id);

        expect(result, isA<Right<Failure, MovieDetailsEntity?>>());
      });
      test("Deve retornar um erro", () async {
        when(() =>
                favoriteDatasource.getFavoriteMovieById(movieDetailsEntity.id))
            .thenThrow(Failure());

        final result = await favoritesRepositoryImp
            .getFavoriteMovieById(movieDetailsEntity.id);

        expect(result, isA<Left<Exception, MovieDetailsEntity?>>());
      });
    });
  });
}
