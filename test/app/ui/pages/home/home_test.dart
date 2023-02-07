import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/bloc/favorites/favorite_bloc.dart';
import 'package:app_movies/app/ui/pages/favorite/favorite.dart';
import 'package:app_movies/app/ui/pages/home/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/home/bloc/states.dart';
import 'package:app_movies/app/ui/pages/home/home.dart';
import 'package:app_movies/app/ui/pages/in_high/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/in_high/bloc/states.dart';
import 'package:app_movies/app/ui/pages/in_high/in_high.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/states.dart';
import 'package:app_movies/app/ui/pages/list_movies/list_movies.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class HomePageBlocMock extends Mock implements HomePageBloc {}

class FavoritePageBlocMock extends Mock implements FavoriteBloc {}

class ListInHighMovieBlocMock extends Mock implements ListInHighMovieBloc {}

class ListMovieBlocMock extends Mock implements ListMovieBloc {}

class ModuleMock extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.instance<HomePageBloc>(HomePageBlocMock()),
        Bind.instance<FavoriteBloc>(FavoritePageBlocMock()),
        Bind.instance<ListInHighMovieBloc>(ListInHighMovieBlocMock()),
        Bind.instance<ListMovieBloc>(ListMovieBlocMock()),
      ];
}

void main() {
  final HomePageBloc bloc = HomePageBlocMock();
  final FavoriteBloc favoriteBloc = FavoritePageBlocMock();
  final ListInHighMovieBloc listInHightBloc = ListInHighMovieBlocMock();
  final ListMovieBloc listMovieBloc = ListMovieBlocMock();
  final state = HomeState(status: SuccessState());
  final stateFavorite = FavoriteState(status: FavoriteStatus.idle);
  final stateListInHighMovie = ListInHighMovieState(status: IdleState());
  final stateListMovie = ListMovieState(status: IdleState());

  setUp(() {
    initModule(ModuleMock(), replaceBinds: [
      Bind.instance<HomePageBloc>(bloc),
      Bind.instance<FavoriteBloc>(favoriteBloc),
      Bind.instance<ListInHighMovieBloc>(listInHightBloc),
      Bind.instance<ListMovieBloc>(listMovieBloc)
    ]);
  });

  group("[UI] - HomePage", () {
    testWidgets("[UI] - Carregamento das paginas do bottomNavigation",
        (tester) async {
      whenListen(
          bloc,
          Stream<HomeState>.fromIterable(
            [state],
          ),
          initialState: state);
      whenListen(
          favoriteBloc,
          Stream<FavoriteState>.fromIterable(
            [stateFavorite],
          ),
          initialState: stateFavorite);
      whenListen(
          listInHightBloc,
          Stream<ListInHighMovieState>.fromIterable(
            [stateListInHighMovie],
          ),
          initialState: stateListInHighMovie);
      whenListen(
          listMovieBloc,
          Stream<ListMovieState>.fromIterable(
            [stateListMovie],
          ),
          initialState: stateListMovie);

      await tester.pumpWidget(MaterialApp(
        home: HomePage(),
      ));

      await tester.pump();

      final buttonFavorito = find.byKey(const Key("FavoritoIcon"));
      final buttonListaFilmes = find.byKey(const Key("listaFilmesIcon"));
      final buttonEmAlta = find.byKey(const Key("EmAltaIcon"));

      await tester.tap(buttonFavorito);
      expect(find.byType(FavoritePage), findsOneWidget);
      await tester.tap(buttonListaFilmes);
      expect(find.byType(ListMoviePage), findsOneWidget);
      await tester.tap(buttonEmAlta);
      expect(find.byType(InHighPage), findsOneWidget);
    });
  });
}
