import 'package:app_movies/app/domain/repositories/favorite_repository_imp.dart';
import 'package:app_movies/app/domain/usecases/delete_favorite_usecase_imp.dart';
import 'package:app_movies/app/domain/usecases/get_favorite_movie_by_id_imp.dart';
import 'package:app_movies/app/domain/usecases/get_favorites_usecase_imp.dart';
import 'package:app_movies/app/domain/usecases/set_favorites_usecase_imp.dart';
import 'package:app_movies/app/ui/pages/home/bloc/bloc.dart';
import 'package:app_movies/app/ui/pages/home/home.dart';
import 'package:app_movies/app/ui/pages/list_movies/bloc/bloc.dart';
import 'package:app_movies/services/dio_http_service_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/datasource/favorite/local/favorite_datasource_imp.dart';
import 'app/datasource/get_movies/remote/get_movies_remote_datasource_imp.dart';
import 'app/domain/usecases/get_movies_usecase_imp.dart';
import 'app/domain/repositories/get_moveis_repository_imp.dart';
import 'app/ui/bloc/favorites/favorite_bloc.dart';
import 'app/ui/pages/in_high/bloc/bloc.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //Services
        Bind.factory((i) => DioHttpServiceImp()),
        //Datasources
        Bind.factory((i) => GetMoviesRemoteDatasourceImp(i())),
        Bind.factory((i) => FavoriteDatasourceLocalImp()),

        //Repositories
        Bind.factory((i) => GetMoviesRepositoryImp(i())),
        Bind.factory((i) => FavoritesRepositoryImp(i())),
        //UseCases
        Bind.factory((i) => GetMoviesUseCaseImp(i())),
        Bind.factory((i) => GetFavoritesUseCaseImp(i())),
        Bind.factory((i) => SetFavoritesUseCaseImp(i())),
        Bind.factory((i) => DeleteFavoriteUseCaseImp(i())),
        Bind.factory((i) => GetFavoriteMovieByIdUseCaseImp(i())),
        //Blocs
        Bind.lazySingleton((i) => FavoriteBloc(i(), i(),i(),i())),
        Bind.lazySingleton((i) => ListMovieBloc(i())),
        Bind.lazySingleton((i) => ListInHighMovieBloc(i())),
        Bind.lazySingleton((i) => HomePageBloc())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const HomePage())
      ];
}
