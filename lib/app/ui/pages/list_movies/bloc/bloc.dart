import 'package:app_movies/app/ui/bloc/bloc_events.dart';
import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/states.dart';
import 'package:bloc/bloc.dart';

import '../../../../domain/usecases/get_movies_usecase.dart';
part 'events.dart';

class ListMovieBloc extends Bloc<BlocBaseEvent, ListMovieState> {
  final GetMoviesUseCase _getMoviesUseCase;

  ListMovieBloc(GetMoviesUseCase getMoviesUseCase)
      : _getMoviesUseCase = getMoviesUseCase,
        super(ListMovieState(status: IdleState())) {
    on<FecthMovies>(_onFetchMovies);
    on<SearchMovieByName>(_onFetchMovieByName);
  }

  Future<void> _onFetchMovies(
      FecthMovies event, Emitter<ListMovieState> emit) async {
    emit(state.copyWith(status: LoadingState()));
    final result = await _getMoviesUseCase();

    result.fold((error) {
      emit(state.copyWith(status: ErrorState()));
    }, (success) {
      emit(ListMovieState(
          status: SuccessState(),
          movieEntity: success.listMovies,
          cachedMovieEntity: success.listMovies));
    });
  }

  Future<void> _onFetchMovieByName(
      SearchMovieByName event, Emitter<ListMovieState> emit) async {
    final result = state.search(event.name);
    emit(state.copyWith(movieEntity: result));
  }
}
