import 'package:app_movies/app/ui/pages/in_high/bloc/states.dart';
import 'package:bloc/bloc.dart';

import '../../../../domain/usecases/get_movies_usecase.dart';
import '../../../bloc/bloc_events.dart';
import '../../../bloc/bloc_states.dart';
part 'events.dart';

class ListInHighMovieBloc extends Bloc<BlocBaseEvent, ListInHighMovieState> {
  final GetMoviesUseCase _getMoviesUseCase;

  ListInHighMovieBloc(GetMoviesUseCase getMoviesUseCase)
      : _getMoviesUseCase = getMoviesUseCase,
        super(ListInHighMovieState(status: const IdleState())) {
    on<FecthInHightAllMovies>(_fecthInHightAllMovies);
  }

  Future<void> _fecthInHightAllMovies(
      FecthInHightAllMovies event, Emitter<ListInHighMovieState> emit) async {
    emit(state.copyWith(status: LoadingState()));
    final result = await _getMoviesUseCase();

    result.fold((error) {
      emit(state.copyWith(status: ErrorState()));
    }, (success) {
      emit(ListInHighMovieState(
          status: SuccessState(),
          movieEntity: success.listMovies,
          cachedMovieEntity: success.listMovies));
    });
  }
}
