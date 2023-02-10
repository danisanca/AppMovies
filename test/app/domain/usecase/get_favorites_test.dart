import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/domain/erros.dart';
import 'package:app_movies/app/domain/repositories/favorite_repository.dart';
import 'package:app_movies/app/domain/usecases/get_favorites_usecase_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}

void main() {
  late FavoritesRepository favoritesRepository;
  late GetFavoritesUseCaseImp getFavoritesUseCaseImp;
  late MovieDetailsEntity movieDetailsEntity;

  setUp(() {
    favoritesRepository = FavoritesRepositoryMock();
    getFavoritesUseCaseImp = GetFavoritesUseCaseImp(favoritesRepository);
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


group("[Domain] - GetFavoritesUseCase", () {
    test("Deve retornar sucesso", () async {
      when(() => favoritesRepository.getFavorites())
          .thenAnswer((invocation) async => Right([movieDetailsEntity]));

      final result = await getFavoritesUseCaseImp();

      expect(result, isA<Right<Failure, List<MovieDetailsEntity>>>());
    });
    test("Deve retornar um erro", () async {
      when(() => favoritesRepository.getFavorites())
          .thenAnswer((invocation) async => Left(Failure()));

      final result = await getFavoritesUseCaseImp();

      expect(result, isA<Left<Failure, List<MovieDetailsEntity>>>());
    });
  });




}
