import 'package:app_movies/app/ui/pages/in_high/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../bloc/favorites/favorite_bloc.dart';
import '../../components/custom_list_card_widget.dart';
import 'bloc/bloc.dart';

class InHighPage extends StatefulWidget {
  const InHighPage({super.key});

  @override
  State<InHighPage> createState() => _InHighPageState();
}

class _InHighPageState extends State<InHighPage> {
  final _bloc = Modular.get<ListInHighMovieBloc>();
  final _favoriteBloc = Modular.get<FavoriteBloc>();

  @override
  void initState() {
    _bloc.add(FecthInHightAllMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: BlocBuilder<ListInHighMovieBloc, ListInHighMovieState>(
              bloc: _bloc,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: state.filterInHighMovies().isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Em alta',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    state.filterInHighMovies().isNotEmpty
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.filterInHighMovies().length,
                            itemBuilder: (_, idx) =>
                                BlocBuilder<FavoriteBloc, FavoriteState>(
                                    bloc: _favoriteBloc,
                                    builder: (context, statefavorite) {
                                      final movie = state.movieEntity[idx];
                                      final isFavorite = statefavorite
                                          .movieEntity
                                          .contains(movie);

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
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
