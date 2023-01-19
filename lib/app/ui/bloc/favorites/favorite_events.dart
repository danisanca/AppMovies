part of 'favorite_bloc.dart';

class GetFavorites extends BlocBaseEvent {
  GetFavorites();
}

class SetFavorites extends BlocBaseEvent {
  final MovieDetailsEntity movie;
  SetFavorites(this.movie);
}


class DeleteFavorite extends BlocBaseEvent {
   final MovieDetailsEntity movie;
  DeleteFavorite(this.movie);
}

class GetFavoriteMovieById extends BlocBaseEvent {
   final MovieDetailsEntity movie;
  GetFavoriteMovieById(this.movie);
}
