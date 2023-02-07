import 'package:app_movies/app/ui/bloc/bloc_states.dart';

import '../../../../domain/entities/movies_details_entity.dart';

class ListMovieState extends BlocBaseState {
  final BlocBaseState status;
  final List<MovieDetailsEntity> movieEntity;
  final List<MovieDetailsEntity> _cachedMovieEntity;

  ListMovieState(
      {List<MovieDetailsEntity> cachedMovieEntity = const [],
      this.status = const IdleState(),
      this.movieEntity = const []})
      : _cachedMovieEntity = cachedMovieEntity;

  ListMovieState copyWith(
          {BlocBaseState? status, List<MovieDetailsEntity>? movieEntity}) =>
      ListMovieState(
          cachedMovieEntity: _cachedMovieEntity,
          status: status ?? this.status,
          movieEntity: movieEntity ?? this.movieEntity);

  List<MovieDetailsEntity> search(String value) {
    if (value == "") {
      return _cachedMovieEntity;
    }
    List<MovieDetailsEntity> list = _cachedMovieEntity
        .where(
          (e) => e.toString().toLowerCase().contains((value.toLowerCase())),
        )
        .toList();
    return list;
  }

  @override
  List<Object?> get props => [status, movieEntity, _cachedMovieEntity];
}
