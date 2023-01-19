import 'package:dio/dio.dart';
import 'http_service.dart';


class DioHttpServiceImp implements HttpService {
  late Dio _dio;
  DioHttpServiceImp() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/4/',
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDMxYTEyYTAyYWViN2MwMTRiYjY2YzIzM2ZiOTc3MSIsInN1YiI6IjYzM2IwZjA2NDgxMzgyMDA3YWEwMzg4MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.15zBsyOdD47p76dc41e_8VLldFAr-9GD1IMz2b4gHdI',
        },
      ),
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
  }
}