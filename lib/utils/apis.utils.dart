// ignore_for_file: non_constant_identifier_names

class API {
  static String REQUEST_IMG(String img) =>
      'https://image.tmdb.org/t/p/w500/$img';

  static const requestMovieList = 'list/1?page=1';
}
