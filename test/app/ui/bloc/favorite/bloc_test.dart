import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/domain/erros.dart';
import 'package:app_movies/app/domain/usecases/delete_favorite_usecase.dart';
import 'package:app_movies/app/domain/usecases/get_favorite_movie_by_id.dart';
import 'package:app_movies/app/domain/usecases/get_favorites_usecase.dart';
import 'package:app_movies/app/domain/usecases/set_favorites_usercase.dart';
import 'package:app_movies/app/ui/bloc/favorites/favorite_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetFavoritesUseCaseMock extends Mock implements GetFavoritesUseCase {}

class SetFavoritesUseCaseMock extends Mock implements SetFavoritesUseCase {}

class DeleteFavoriteUseCaseMock extends Mock implements DeleteFavoriteUseCase {}

class GetFavoriteMovieByIdUseCaseMock extends Mock
    implements GetFavoriteMovieByIdUseCase {}

void main() {
  late GetFavoritesUseCase getFavoritesUseCase;
  late SetFavoritesUseCase setFavoritesUseCase;
  late DeleteFavoriteUseCase deleteFavoriteUseCase;
  late GetFavoriteMovieByIdUseCase getFavoriteMovieByIdUseCase;
  late FavoriteBloc bloc;
  late FavoriteState state;
  late MovieDetailsEntity movieDetailsEntity;
  late List<MovieDetailsEntity> copyList;
  late List<MovieDetailsEntity> copylist2;

  setUp(() {
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
    getFavoritesUseCase = GetFavoritesUseCaseMock();
    setFavoritesUseCase = SetFavoritesUseCaseMock();
    deleteFavoriteUseCase = DeleteFavoriteUseCaseMock();
    getFavoriteMovieByIdUseCase = GetFavoriteMovieByIdUseCaseMock();
    state = FavoriteState(status: FavoriteStatus.idle);
    bloc = FavoriteBloc(getFavoritesUseCase, setFavoritesUseCase,
        deleteFavoriteUseCase, getFavoriteMovieByIdUseCase);
    copyList = [movieDetailsEntity];
    copylist2 = copyList.map((e) => e).toList();
  });
  group("[Bloc] - Favorite", () {
    group("[event] - GetFavorites ", () {
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar sucesso",
        build: () => bloc,
        setUp: () async {
          when(
            () => getFavoritesUseCase(),
          ).thenAnswer((invocation) async => Right([movieDetailsEntity]));
        },
        act: (bloc) => bloc.add(GetFavorites()),
        expect: () => [
          state.copyWith(status: FavoriteStatus.loading),
          FavoriteState(
              status: FavoriteStatus.successGetFavorite,
              movieEntity: [movieDetailsEntity])
        ],
      );
      blocTest("Quando retornar error",
          build: () => bloc,
          setUp: () async {
            when(
              () => getFavoritesUseCase(),
            ).thenAnswer((invocation) async => Left(Failure()));
          },
          act: (bloc) => bloc.add(GetFavorites()),
          expect: () => [
                state.copyWith(status: FavoriteStatus.loading),
                state.copyWith(status: FavoriteStatus.failure)
              ]);
    });
    group("[event] - SetFavorites ", () {
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar sucesso",
        build: () => bloc,
        setUp: () async {
          when(
            () => setFavoritesUseCase(movieDetailsEntity),
          ).thenAnswer((invocation) async => const Right(true));
        },
        act: (bloc) => bloc.add(SetFavorites(movieDetailsEntity)),
        expect: () => [
          state.copyWith(status: FavoriteStatus.loading),
          FavoriteState(
              status: FavoriteStatus.successSetFavorite,
              movieEntity: [...state.movieEntity, movieDetailsEntity])
        ],
      );
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar error",
        build: () => bloc,
        setUp: () async {
          when(
            () => setFavoritesUseCase(movieDetailsEntity),
          ).thenAnswer((invocation) async => Left(Failure()));
        },
        act: (bloc) => bloc.add(SetFavorites(movieDetailsEntity)),
        expect: () => [
          state.copyWith(status: FavoriteStatus.loading),
          state.copyWith(status: FavoriteStatus.failure),
        ],
      );
    });
    group("[event] - DeleteFavorite ", () {
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar sucesso",
        build: () => bloc,
        setUp: () async {
          when(
            () => deleteFavoriteUseCase(movieDetailsEntity.id),
          ).thenAnswer((invocation) async => const Right(true));
          copylist2.remove(movieDetailsEntity);
        },
        act: (bloc) => bloc.add(DeleteFavorite(movieDetailsEntity)),
        expect: () => [
          state.copyWith(
              status: FavoriteStatus.successDelete, movieEntity: copylist2)
        ],
      );
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar error",
        build: () => bloc,
        setUp: () async {
          when(
            () => deleteFavoriteUseCase(movieDetailsEntity.id),
          ).thenAnswer((invocation) async => Left(Failure()));
        },
        act: (bloc) => bloc.add(DeleteFavorite(movieDetailsEntity)),
        expect: () => [
          state.copyWith(status: FavoriteStatus.failure),
        ],
      );
    });
    group("[event] - GetFavoriteMovieById ", () {
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar sucesso",
        build: () => bloc,
        setUp: () async {
          when(
            () => getFavoriteMovieByIdUseCase(movieDetailsEntity.id),
          ).thenAnswer((invocation) async => Right(movieDetailsEntity));
        },
        act: (bloc) => bloc.add(GetFavoriteMovieById(movieDetailsEntity)),
        expect: () => [
          state.copyWith(status: FavoriteStatus.successGetFavoriteMovieById),
        ],
      );
      blocTest<FavoriteBloc, FavoriteState>(
        "Quando retornar erro",
        build: () => bloc,
        setUp: () async {
          when(
            () => getFavoriteMovieByIdUseCase(movieDetailsEntity.id),
          ).thenAnswer((invocation) async => Left(Failure()));
        },
        act: (bloc) => bloc.add(GetFavoriteMovieById(movieDetailsEntity)),
        expect: () => [
          state.copyWith(status: FavoriteStatus.failure),
        ],
      );
    });
  });
}
