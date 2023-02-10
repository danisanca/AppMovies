import 'package:app_movies/app/ui/bloc/favorites/favorite_bloc.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import '../../components/custom_list_card_widget.dart';

class ListMoviePage extends StatelessWidget {
  const ListMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListMovieContent(
        bloc: Modular.get<ListMovieBloc>(),
        favoriteBloc: Modular.get<FavoriteBloc>());
  }
}

class ListMovieContent extends StatefulWidget {
  final ListMovieBloc bloc;
  final FavoriteBloc favoriteBloc;

  const ListMovieContent(
      {super.key, required this.bloc, required this.favoriteBloc});

  @override
  State<ListMovieContent> createState() => _ListMovieContentState();
}

class _ListMovieContentState extends State<ListMovieContent> {
  @override
  void initState() {
    widget.bloc.add(FecthMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: BlocBuilder<ListMovieBloc, ListMovieState>(
              bloc: widget.bloc,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: state.movieEntity.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Movies',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Pequisar filme...',
                            ),
                            onChanged: (value) =>
                                widget.bloc.add(SearchMovieByName(value)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    state.movieEntity.isNotEmpty
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.movieEntity.length,
                            itemBuilder: (_, idx) =>
                                BlocBuilder<FavoriteBloc, FavoriteState>(
                                    bloc: widget.favoriteBloc,
                                    builder: (context, statefavorite) {
                                      final movie = state.movieEntity[idx];
                                      final isFavorite = statefavorite
                                          .movieEntity
                                          .contains(movie);

                                      return CustomListCardWidget(
                                          isFavorite: isFavorite,
                                          favoriteTap: () {
                                            if (isFavorite) {
                                              widget.favoriteBloc.add(
                                                  DeleteFavorite(
                                                      state.movieEntity[idx]));
                                            } else {
                                              widget.favoriteBloc.add(
                                                  SetFavorites(
                                                      state.movieEntity[idx]));
                                            }
                                          },
                                          movie: state.movieEntity[idx]);
                                    }),
                            separatorBuilder: (_, __) => const Divider(),
                          )
                        : Center(
                            child: Lottie.asset('assets/lottie.json'),
                          ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
