import '../../../../domain/entities/movies_details_entity.dart';
import '../../../bloc/bloc_states.dart';

class ListInHighMovieState extends BlocBaseState {
  final BlocBaseState status;
  final List<MovieDetailsEntity> movieEntity;
  final List<MovieDetailsEntity> _cachedMovieEntity;

  List<MovieDetailsEntity> filterInHighMovies() {
    final List<MovieDetailsEntity> copyMovieList = [];
    copyMovieList.addAll(_cachedMovieEntity);
    copyMovieList.retainWhere((element) => element.voteAverage > 7.9);
    return copyMovieList;
  }

  ListInHighMovieState(
      {List<MovieDetailsEntity> cachedMovieEntity = const [],
      required this.status,
      this.movieEntity = const []})
      : _cachedMovieEntity = cachedMovieEntity;

  ListInHighMovieState copyWith(
          {BlocBaseState? status, List<MovieDetailsEntity>? movieEntity}) =>
      ListInHighMovieState(
          cachedMovieEntity: _cachedMovieEntity,
          status: status ?? this.status,
          movieEntity: movieEntity ?? this.movieEntity);

  @override
  List<Object?> get props => [status, movieEntity, _cachedMovieEntity];
}
