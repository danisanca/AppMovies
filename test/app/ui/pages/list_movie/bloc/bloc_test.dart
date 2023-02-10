import 'package:app_movies/app/domain/entities/movies_entity.dart';
import 'package:app_movies/app/domain/usecases/get_movies_usecase.dart';
import 'package:app_movies/app/infra/dtos/movies_details_dto.dart';
import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/bloc.dart';

class GetMoviesUseCaseMock extends Mock implements GetMoviesUseCase {}

void main() {
  late GetMoviesUseCase getMoviesUseCase;
  late ListMovieBloc bloc;
  late ListMovieState state;
  late MovieEntity movieEntity;

  final list = [
    MovieDetailsDto.fromJson({
      "adult": false,
      "backdrop_path": "/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg",
      "id": 634649,
      "media_type": "movie",
      "original_language": "en",
      "original_title": "Spider-Man: No Way Home",
      "overview":
          "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
      "popularity": 444.452,
      "poster_path": "/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg",
      "release_date": "2021-12-15",
      "title": "Spider-Man: No Way Home",
      "video": false,
      "vote_average": 8,
      "vote_count": 16031
    })
  ];

  setUp(() {
    getMoviesUseCase = GetMoviesUseCaseMock();
    state = ListMovieState(
        status: const IdleState(), movieEntity: list, cachedMovieEntity: list);
    bloc = ListMovieBloc(getMoviesUseCase, initialstate: state);
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
        listMovies: list,
        revenue: 0,
        runtime: 0,
        sortBy: "sortBy",
        totalPages: 1,
        totalResults: 1);
  });

  group("[Bloc] - ListFilm", () {
    group("[Event] - FetchMovies", () {
      blocTest<ListMovieBloc, ListMovieState>(
        "Quando retornar sucesso",
        build: () => bloc,
        setUp: () async {
          when(
            () => getMoviesUseCase(),
          ).thenAnswer((invocation) async => Right(movieEntity));
        },
        //Chama o evento FetchMovie
        act: (bloc) => bloc.add(FecthMovies()),
        expect: () => [
          state.copyWith(status: LoadingState()),
          ListMovieState(
              status: SuccessState(),
              movieEntity: movieEntity.listMovies,
              cachedMovieEntity: movieEntity.listMovies)
        ],
      );
      
      blocTest<ListMovieBloc, ListMovieState>(
        "Quando retornar error",
        build: () => bloc,
        setUp: () async {
          when(
            () => getMoviesUseCase(),
          ).thenAnswer((invocation) async => Left(Exception()));
        },
        act: (bloc) => bloc.add(FecthMovies()),
        expect: () => [
          state.copyWith(status: LoadingState()),
          state.copyWith(status: ErrorState())
        ],
      );
    });
    group("[event] - FetchMovieByName", () {
      blocTest<ListMovieBloc, ListMovieState>("Retorna o filme pesquisado",
          build: () => bloc,
          act: (bloc) => bloc.add(SearchMovieByName("Spider-Man: No Way Home")),
          expect: () => [state.copyWith(movieEntity: list)]);

      blocTest<ListMovieBloc, ListMovieState>(
          "Retorna uma lista vazia caso nao encontre o filme",
          build: () => bloc,
          act: (bloc) => bloc.add(SearchMovieByName("Eternal")),
          expect: () => [state.copyWith(movieEntity: [])]);

      blocTest<ListMovieBloc, ListMovieState>(
          "Retorna a lista de filmes atual caso nao haja uma valor a pesquisar",
          build: () => bloc,
          act: (bloc) => bloc.add(SearchMovieByName("")),
          expect: () => [state.copyWith(movieEntity: list)]);
    });
  });
}
