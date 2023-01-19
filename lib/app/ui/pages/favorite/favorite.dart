import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../bloc/favorites/favorite_bloc.dart';
import '../../components/custom_list_card_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _bloc = Modular.get<FavoriteBloc>();
  final _favoriteBloc = Modular.get<FavoriteBloc>();
  @override
  void initState() {
    _bloc.add(GetFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
              bloc: _bloc,
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
                            'Favoritos',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    if (state.movieEntity.isEmpty) ...[
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied_outlined,
                              size: 72,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Não há filmes favoritos.',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                    if (state.status == FavoriteStatus.loading) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                    if (state.movieEntity.isNotEmpty &&
                        state.status != FavoriteStatus.loading) ...[
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.movieEntity.length,
                        itemBuilder: (_, idx) =>
                            BlocBuilder<FavoriteBloc, FavoriteState>(
                                bloc: _favoriteBloc,
                                builder: (context, statefavorite) {
                                  final movie = state.movieEntity[idx];
                                  final isFavorite =
                                      statefavorite.movieEntity.contains(movie);

                                  return CustomListCardWidget(
                                      isFavorite: isFavorite,
                                      favoriteTap: () {
                                        if (isFavorite) {
                                          _favoriteBloc.add(DeleteFavorite(
                                              state.movieEntity[idx]));
                                        } else {
                                          _favoriteBloc.add(SetFavorites(
                                              state.movieEntity[idx]));
                                        }
                                      },
                                      movie: state.movieEntity[idx]);
                                }),
                        separatorBuilder: (_, __) => const Divider(),
                      )
                    ],
                  ],
                );
              }),
        ),
      ),
    );
  }
}
