import 'package:app_movies/app/ui/pages/favorite/favorite.dart';
import 'package:app_movies/app/ui/pages/home/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/home/bloc/states.dart';
import 'package:app_movies/app/ui/pages/in_high/in_high.dart';
import 'package:app_movies/app/ui/pages/list_movies/list_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = Modular.get<HomePageBloc>();

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    _bloc.add(SaveIndexPage(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Smart Cine'),
        ),
        body: BlocConsumer<HomePageBloc, HomeState>(
            bloc: _bloc,
            listener: (context, state) {
              //_pageController.jumpToPage(state.indexPage);
            },
            builder: (context, snapshot) {
              return IndexedStack(
                index: _bloc.state.indexPage,
                //controller: _pageController,
                children: const [
                  FavoritePage(),
                  ListMoviePage(),
                  InHighPage(),
                ],
              );
            }),
        bottomNavigationBar: BlocConsumer<HomePageBloc, HomeState>(
            bloc: _bloc,
            listener: (context, state) {
              //_pageController.jumpToPage(state.indexPage);
            },
            builder: (context, snapshot) {
              return BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,key: Key("FavoritoIcon"),),
                    label: 'Favoritos',
                    
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie,key: Key("listaFilmesIcon"),),
                    label: 'Lista de Filmes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star,key: Key("EmAltaIcon"),),
                    label: 'Em Alta',
                  ),
                ],
                currentIndex: _bloc.state.indexPage,
                selectedItemColor: const Color.fromARGB(255, 110, 120, 247),
                onTap: _onItemTapped,
              );
            }));
  }
}
