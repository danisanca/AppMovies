// ignore_for_file: file_names

import 'package:app_movies/app/infra/dtos/movies_details_dto.dart';
import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/bloc/favorites/favorite_bloc.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/states.dart';
import 'package:app_movies/app/ui/components/custom_list_card_widget.dart';
import 'package:app_movies/app/ui/pages/list_movies/list_movies.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class ListMovieBlockMock extends Mock implements ListMovieBloc {}

class FavoriteBlockMock extends Mock implements FavoriteBloc {}

void main() {
  //Mock dos dados
  final list = [
    MovieDetailsDto.fromJson({
      "adult": false,
      "backdrop_path": "/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg",
      "id": 634649,
      "media_type": "movie",
      "original_language": "en",
      "original_title": "Spider-Man: No Way Home",
      "overview":
          "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
      "popularity": 444.452,
      "poster_path": "/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg",
      "release_date": "2021-12-15",
      "title": "Spider-Man: No Way Home",
      "video": false,
      "vote_average": 8,
      "vote_count": 16031
    })
  ];

  final ListMovieBloc bloc = ListMovieBlockMock();
  final FavoriteBloc favoriteBloc = FavoriteBlockMock();
  final state = ListMovieState(status: const IdleState());
  final stateFavorite =
      FavoriteState(status: FavoriteStatus.idle, movieEntity: list);

  setUp(() {});

  group('[UI] - ListFilmPage', () {
    testWidgets("[UI] - ListMovie Carregando componentes", (tester) async {
      //Quando o estado do block estiver vazio
      //ARRANGE
      whenListen(
          bloc,
          Stream<ListMovieState>.fromIterable(
            //estado a serem testados
            [state],
          ),
          initialState: state);

      //Construindo widget
      //ACT
      await tester.pumpWidget(MaterialApp(
        home: ListMovieContent(bloc: bloc, favoriteBloc: favoriteBloc),
      ));

      //Atualizando tela apos construcao
      await tester.pump();

      //Esperando que aconteça.
      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets('deve retornar uma lista de card de filmes', (tester) async {
      //Arrange
      whenListen(
          bloc,
          Stream<ListMovieState>.fromIterable(
              [ListMovieState(status: SuccessState(), movieEntity: list)]),
          initialState:
              ListMovieState(status: SuccessState(), movieEntity: list));
      whenListen(
          favoriteBloc, Stream<FavoriteState>.fromIterable([stateFavorite]),
          initialState: stateFavorite);

      //ACT
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(
          home: ListMovieContent(bloc: bloc, favoriteBloc: favoriteBloc),
        ));
        await tester.pump();
      });
      //ASSERT
      expect(find.byType(CustomListCardWidget), findsOneWidget);
    });
  });
}
