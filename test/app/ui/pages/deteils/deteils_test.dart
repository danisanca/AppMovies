import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/ui/pages/deteils/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  late MovieDetailsEntity movieDetailsEntity;

  setUp(() {
    movieDetailsEntity = const MovieDetailsEntity(
        adult: false,
        backdropPath: "/14QbnygCuTO0vl7CAFmPf1fgZfV.jpg",
        id: 634649,
        mediaType: "movie",
        originalLanguage: "en",
        originalTitle: "Spider-Man: No Way Home",
        overview:
            "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be SpiderMan.",
        popularity: 444.452,
        posterPath: "/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg",
        releaseDate: "2021-12-15",
        title: "Spider-Man: No Way Home",
        video: false,
        voteAverage: 8,
        voteCount: 16031);
  });

  group("[UI] - ListFilmPage", () {
    testWidgets("Retorna a pagina com o filme selecionado", (tester) async {
      //ACT
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(
          home: DetailsPage(
            movie: movieDetailsEntity,
          ),
        ));
        await tester.pump();
      });

      expect(find.byKey(const Key("Title")), findsOneWidget);
      expect(find.byType(Hero), findsOneWidget);
      expect(find.byKey(const Key("ReleaseDate")), findsOneWidget);
    });
  });
}
