// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'favorite_bloc.dart';

enum FavoriteStatus {
  idle,
  successGetFavorite,
  successGetFavoriteMovieById,
  successSetFavorite,
  successDelete,
  failure,
  loading
}

class FavoriteState extends BlocBaseState {
  final FavoriteStatus status;
  final List<MovieDetailsEntity> movieEntity;

  FavoriteState({required this.status, this.movieEntity = const []});

  FavoriteState copyWith(
          {FavoriteStatus? status, List<MovieDetailsEntity>? movieEntity}) =>
      FavoriteState(
          status: status ?? this.status,
          movieEntity: movieEntity ?? this.movieEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [status, movieEntity];
}
