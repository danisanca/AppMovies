import 'package:equatable/equatable.dart';

class MovieDetailsEntity extends Equatable{
  const MovieDetailsEntity({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
   final bool adult;
   final String backdropPath;
   final int id;
   final String mediaType;
   final String originalLanguage;
   final String originalTitle;
   final String overview;
   final double popularity;
   final String posterPath;
   final String releaseDate;
   final String title;
   final bool video;
   final double voteAverage;
   final int voteCount;

  @override
  String toString() {
    return 'MovieDetailsEntity(adult: $adult, backdropPath: $backdropPath, id: $id, mediaType: $mediaType, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
  
  @override
  List<Object?> get props => [id];

}