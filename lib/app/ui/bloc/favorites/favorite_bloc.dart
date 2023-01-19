// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_movies/app/domain/entities/movies_details_entity.dart';
import 'package:app_movies/app/domain/usecases/delete_favorite_usecase.dart';
import 'package:app_movies/app/domain/usecases/get_favorite_movie_by_id.dart';
import 'package:app_movies/app/domain/usecases/set_favorites_usercase.dart';
import 'package:app_movies/app/ui/bloc/bloc_states.dart';
import 'package:bloc/bloc.dart';

import 'package:app_movies/app/domain/usecases/get_favorites_usecase.dart';
import 'package:app_movies/app/ui/bloc/bloc_events.dart';

part 'favorite_states.dart';
part 'favorite_events.dart';

class FavoriteBloc extends Bloc<BlocBaseEvent, FavoriteState> {
  final GetFavoritesUseCase _getFavorites;
  final SetFavoritesUseCase _setFavorites;
  final DeleteFavoriteUseCase _deleteFavorite;
  final GetFavoriteMovieByIdUseCase _getFavoriteMovieById;

  FavoriteBloc(
    GetFavoritesUseCase getFavorites,
    SetFavoritesUseCase setFavorites,
    DeleteFavoriteUseCase deleteFavoriteUseCase,
    GetFavoriteMovieByIdUseCase getFavoriteMovieByIdUseCase,
  )   : _getFavorites = getFavorites,
        _setFavorites = setFavorites,
        _deleteFavorite = deleteFavoriteUseCase,
        _getFavoriteMovieById = getFavoriteMovieByIdUseCase,
        super(FavoriteState(status: FavoriteStatus.idle)) {
    on<GetFavorites>(_onGetFavorites);
    on<SetFavorites>(_onSetFavorites);
    on<DeleteFavorite>(_onDeleteFavorite);
    on<GetFavoriteMovieById>(_onGetFavoriteMovieById);
  }

  Future<void> _onGetFavorites(
      GetFavorites event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final result = await _getFavorites();

    result.fold((error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }, (success) {
      emit(FavoriteState(
          status: FavoriteStatus.successGetFavorite, movieEntity: success));
    });
  }

  Future _onSetFavorites(
      SetFavorites event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final result = await _setFavorites(event.movie);

    result.fold((error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }, (success) {
      emit(state.copyWith(
          status: FavoriteStatus.successSetFavorite,
          movieEntity: [...state.movieEntity, event.movie]));
    });
  }

  Future _onDeleteFavorite(
      DeleteFavorite event, Emitter<FavoriteState> emit) async {
    final result = await _deleteFavorite(event.movie.id);

    result.fold((error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }, (success) {
      final List<MovieDetailsEntity> copyList = [];
      copyList.addAll(state.movieEntity);
      copyList.remove(event.movie);


      emit(state.copyWith(
        status: FavoriteStatus.successDelete,
        movieEntity: copyList
      ));
    });
  }

  Future _onGetFavoriteMovieById(
      GetFavoriteMovieById event, Emitter<FavoriteState> emit) async {
    final result = await _getFavoriteMovieById(event.movie.id);

    result.fold((error) {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }, (success) {
      emit(state.copyWith(status: FavoriteStatus.successGetFavoriteMovieById));
    });
  }
}
