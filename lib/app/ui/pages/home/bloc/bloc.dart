import 'package:app_movies/app/ui/bloc/bloc_events.dart';
import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/pages/home/bloc/states.dart';
import 'package:bloc/bloc.dart';
part 'events.dart';

class HomePageBloc extends Bloc<BlocBaseEvent, HomeState> {
  HomePageBloc() : super(HomeState(status: SuccessState())) {
    on<SaveIndexPage>(_onSaveIndexPage);
  }

  Future<void> _onSaveIndexPage(
      SaveIndexPage event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: SuccessState(), index: event.index));
  }
}
