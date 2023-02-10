import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/pages/home/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/home/bloc/states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomePageBloc bloc;
  late HomeState state;
  setUp(() {
    state = HomeState(status: SuccessState());
    bloc = HomePageBloc();
  });

  group("[Bloc] - HomeBloc", () {
    group("[Event] - SaveIndexPage", () {
      blocTest<HomePageBloc, HomeState>("Verifica se o valor do botao clicao foi salvo.",
          build: () => bloc,
          act: (bloc) => bloc.add(SaveIndexPage(0)),
          expect: () => [
                state.copyWith(index: 0),
              ]);
    });
  });
}
