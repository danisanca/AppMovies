part of 'bloc.dart';

class FecthMovies extends BlocBaseEvent {
  FecthMovies();
}

class SearchMovieByName extends BlocBaseEvent {
  final String name;

  SearchMovieByName(this.name);
}
