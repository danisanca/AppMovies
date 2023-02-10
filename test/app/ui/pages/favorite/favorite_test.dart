// ignore_for_file: unused_local_variable

import 'package:app_movies/app/infra/dtos/movies_details_dto.dart';
import 'package:app_movies/app/ui/bloc/favorites/favorite_bloc.dart';
import 'package:app_movies/app/ui/components/custom_list_card_widget.dart';
import 'package:app_movies/app/ui/pages/favorite/favorite.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class FavoriteBlockMock extends Mock implements FavoriteBloc {}

class ModuleMock extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.instance<FavoriteBloc>(FavoriteBlockMock()),
      ];
}

void main() {
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

  final FavoriteBloc bloc = FavoriteBlockMock();
  final state = FavoriteState(status: FavoriteStatus.idle);

  setUp(() {
    initModule(ModuleMock(), replaceBinds: [Bind.instance<FavoriteBloc>(bloc)]);
  });

  group("[UI] - FavoritePage", () {
    testWidgets('[UI] - Sucesso ao carregar lista de favoritos',
        (tester) async {
      whenListen(
          bloc,
          Stream<FavoriteState>.fromIterable(
            [
              FavoriteState(
                  status: FavoriteStatus.successGetFavorite, movieEntity: list)
            ],
          ),
          initialState: FavoriteState(
              status: FavoriteStatus.successGetFavorite, movieEntity: list));

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const MaterialApp(
          home: FavoritePage(),
        ));
        await tester.pump();
      });

      expect(find.byType(CustomListCardWidget), findsOneWidget);
    });
    testWidgets("[UI] - Retornar msg caso a lista de favoritos estiver vaiza",
        (tester) async {
      whenListen(
          bloc,
          Stream<FavoriteState>.fromIterable(
              [FavoriteState(status: FavoriteStatus.idle)]),
          initialState: FavoriteState(
              status: FavoriteStatus.idle, movieEntity: const []));

      await tester.pumpWidget(const MaterialApp(
        home: FavoritePage(),
      ));

      await tester.pump();
      
      expect(find.byKey(const Key("ListaVazia")), findsOneWidget);
    });
  });
}
