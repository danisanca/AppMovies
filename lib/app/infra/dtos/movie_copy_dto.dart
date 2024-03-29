import '../../domain/entities/movies_details_entity.dart';
import '../../domain/entities/movies_entity.dart';

extension MovieDto on MovieEntity {
  MovieEntity copyWith({
    List<MovieDetailsEntity>? listMovies,
  }) {
    return MovieEntity(
      averageRating: averageRating,
      backdropPath: backdropPath,
      description: description,
      id: id,
      iso_3166_1: iso_3166_1,
      iso_639_1: iso_639_1,
      name: name,
      page: page,
      posterPath: posterPath,
      public: public,
      listMovies: listMovies ?? this.listMovies,
      revenue: revenue,
      runtime: runtime,
      sortBy: sortBy,
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}