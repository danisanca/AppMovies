import '../../domain/entities/movies_details_entity.dart';

extension MovieDetailsDto on MovieDetailsEntity {
  Map toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'media_type': mediaType,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  static MovieDetailsEntity fromJson(Map json) {
    return MovieDetailsEntity(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      mediaType: json['media_type'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  static Map<String, dynamic> fromObjectToMap(MovieDetailsEntity movieDeteils) {
    return {
      'adult': movieDeteils.adult == true ? 1 : 0,
      'backdrop_path': movieDeteils.backdropPath,
      'movieId': movieDeteils.id,
      'media_type': movieDeteils.mediaType,
      'original_language': movieDeteils.originalLanguage,
      'original_title': movieDeteils.originalTitle,
      'overview': movieDeteils.overview,
      'popularity': movieDeteils.popularity,
      'poster_path': movieDeteils.posterPath,
      'release_date': movieDeteils.releaseDate,
      'title': movieDeteils.title,
      'video': movieDeteils.video == true ? 1 : 0,
      'vote_average': movieDeteils.voteAverage,
      'vote_count': movieDeteils.voteCount
    };
  }
}
