import 'package:app_movies/app/infra/dtos/movies_details_dto.dart';
import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/states.dart';
import 'package:app_movies/app/ui/components/custom_list_card_widget.dart';
import 'package:app_movies/app/ui/pages/list_movies/list_movies.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class ListMovieBlockMock extends Mock implements ListMovieBloc {}

class ModuleMock extends Module {
  @override
  List<Bind<Object>> get binds =>
      [Bind.instance<ListMovieBloc>(ListMovieBlockMock())];
}

void main() {
  final ListMovieBloc bloc = ListMovieBlockMock();
  final list = [
    MovieDetailsDto.fromJson({
      "adult": false,
      "backdrop_path": "/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg",
      "genre_ids": [28, 12, 878],
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
  setUp(() {
    initModule(ModuleMock(), replaceBinds: [
      Bind.instance<ListMovieBloc>(bloc),
    ]);
  });

  group('[UI] - HomePage', () {
    testWidgets('deve retornar um luttie quando estiver vazio ou carregando',
        (tester) async {
      //Arrange
      whenListen(
          bloc,
          Stream<ListMovieState>.fromIterable(
              [ListMovieState(status: LoadingState())]),
          initialState: ListMovieState(status: LoadingState()));

      //ACT
      await tester.pumpWidget(const MaterialApp(
        home: ListMoviePage(),
      ));

      await tester.pump();
      //ASSERT
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

      //ACT
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const MaterialApp(
          home: ListMoviePage(),
        ));
        await tester.pump();

        
      
      });
      //ASSERT
      expect(find.byType(CustomListCardWidget), findsOneWidget);
    });
  });
}
