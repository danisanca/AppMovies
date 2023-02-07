import 'package:app_movies/app/domain/entities/movies_entity.dart';
import 'package:app_movies/app/domain/repositories/get_movies_repository.dart';
import 'package:app_movies/app/domain/usecases/get_movies_usecase_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMoviesRepositoryMock extends Mock implements GetMoviesRepository {}

void main() {
  late GetMoviesRepository getMoviesRepository;
  late GetMoviesUseCaseImp getMoviesUseCaseImp;
  late MovieEntity movieEntity;

  setUp(() {
    getMoviesRepository = GetMoviesRepositoryMock();
    getMoviesUseCaseImp = GetMoviesUseCaseImp(getMoviesRepository);
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

  group("[Domain] - GetMoviesUseCase", () {
    test("Deve retornar sucesso", () async {
      when(() => getMoviesRepository())
          .thenAnswer((invocation) async => Right(movieEntity));

      final result = await getMoviesUseCaseImp();

      expect(result, isA<Right<Exception, MovieEntity>>());
    });
    test("Deve retornar um erro", () async {
      when(() => getMoviesRepository())
          .thenAnswer((invocation) async => Left(Exception()));

      final result = await getMoviesUseCaseImp();

      expect(result, isA<Left<Exception, MovieEntity>>());
    });
  });
}
