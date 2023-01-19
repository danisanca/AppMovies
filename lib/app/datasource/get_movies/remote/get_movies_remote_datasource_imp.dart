import 'package:app_movies/app/infra/dtos/movies_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../services/http_service.dart';
import '../../../../../utils/apis.utils.dart';
import '../../../domain/entities/movies_entity.dart';
import '../get_movies_datasource.dart';

class GetMoviesRemoteDatasourceImp implements GetMoviesDataSource {
  final HttpService _httpService;
  GetMoviesRemoteDatasourceImp(this._httpService);

  @override
  Future<Either<Exception, MovieEntity>> call() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      var result = await _httpService.get(API.requestMovieList);
      return Right(MovieDto.fromJson(result.data));
    } on DioError catch (e) {
      return Left(Exception('Falha no datasource: $e'));
    }
  }
}