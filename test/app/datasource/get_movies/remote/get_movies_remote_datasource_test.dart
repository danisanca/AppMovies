import 'package:app_movies/app/datasource/get_movies/remote/get_movies_remote_datasource_imp.dart';
import 'package:app_movies/app/domain/entities/movies_entity.dart';
import 'package:app_movies/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HttpServiceMock extends Mock implements HttpService {}

void main() {
  late HttpService httpService;
  late Map<String, dynamic> movieEntity;
  late GetMoviesRemoteDatasourceImp getMoviesRemoteDatasourceImp;

  setUp(() {
    httpService = HttpServiceMock();
    getMoviesRemoteDatasourceImp = GetMoviesRemoteDatasourceImp(httpService);
    movieEntity = {
      'average_rating': 0.0,
      'backdrop_path': "backdropPath",
      'description': "description",
      'id': 0,
      'iso_3166_1': "iso_3166_1",
      'iso_639_1': "iso_639_1",
      'name': "name",
      'page': 0,
      'poster_path': "posterPath",
      'public': false,
      'results': [],
      'revenue': 0,
      'runtime': 0,
      'sort_by': "sortBy",
      'total_pages': 0,
      'total_results': 0,
    };
  });

  group("[DataSource] - GetMoviesDataSource ", () {
    test("Deve Retornar Sucesso", () async {
      when(() => httpService.get(any())).thenAnswer((invocation) async =>
          Response(
              data: movieEntity,
              statusCode: 200,
              requestOptions: RequestOptions(path: "")));
      final resul = await getMoviesRemoteDatasourceImp();

      expect(resul, isA<MovieEntity>());
    });
  });
}
