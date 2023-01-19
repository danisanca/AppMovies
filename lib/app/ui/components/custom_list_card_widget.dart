import 'package:flutter/material.dart';

import '../../../utils/apis.utils.dart';
import '../../domain/entities/movies_details_entity.dart';
import '../pages/deteils/details_page.dart';

class CustomListCardWidget extends StatelessWidget {
  final MovieDetailsEntity movie;
  const CustomListCardWidget(
      {super.key,
      required this.movie,
      this.favoriteTap,
      required this.isFavorite});

  final VoidCallback? favoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailsPage(movie: movie),
                fullscreenDialog: true),
          );
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  child: Hero(
                    tag: movie.id,
                    child: Image.network(
                      API.REQUEST_IMG(movie.posterPath),
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return const CircularProgressIndicator.adaptive();
                      },
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    const Spacer(),
                    Text('Popularidade: ${movie.popularity}'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Votos: ${movie.voteAverage}'),
                        InkWell(
                          onTap: favoriteTap,
                          child: Icon(
                            isFavorite == true
                                ? Icons.favorite
                                : Icons.heart_broken_sharp,
                            color: isFavorite == false
                                ? Color.fromARGB(255, 69, 107, 231)
                                : Colors.red,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
