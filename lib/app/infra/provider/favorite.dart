// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

final String tableFavorite = 'Favorite';
final String columnId = 'id';
final String columnAdult = 'adult';
final String columnBackdropPath = 'backdrop_path';
final String columnMovieId = 'movieId';
final String columnMediaType = 'media_type';
final String columnOriginalLanguage = 'original_language';
final String columnOriginalTitle = 'original_title';
final String columnOverview = 'overview';
final String columnPopularity = 'popularity';
final String columnPosterPath = 'poster_path';
final String columnReleaseDate = 'release_date';
final String columnTitle = 'title';
final String columnVideo = 'video';
final String columnVoteAverage = 'vote_average';
final String columnVoteCount = 'vote_count';

class Favorite {
  final int id;
  final int adult;
  final String backdropPath;
  final int movieId;
  final String mediaType;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final int video;
  final double voteAverage;
  final int voteCount;

  Favorite({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.movieId,
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

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnAdult: adult == 1 ? true : false,
      columnBackdropPath: backdropPath,
      columnMovieId: movieId,
      columnMediaType: mediaType,
      columnOriginalLanguage: originalLanguage,
      columnOriginalTitle: originalTitle,
      columnOverview: overview,
      columnPopularity: popularity,
      columnPosterPath: posterPath,
      columnReleaseDate: releaseDate,
      columnTitle: title,
      columnVideo: video == 1 ? true : false,
      columnVoteAverage: voteAverage,
      columnVoteCount: voteCount
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static fromMap(Map<dynamic, dynamic> map) {
    return Favorite(
      id: map[columnId],
      adult: map[columnAdult] == true ? 1 : 0,
      backdropPath: map[columnBackdropPath],
      movieId: map[columnMovieId],
      mediaType: map[columnMediaType],
      originalLanguage: map[columnOriginalLanguage],
      originalTitle: map[columnOriginalTitle],
      overview: map[columnOverview],
      popularity: map[columnPopularity],
      posterPath: map[columnPosterPath],
      releaseDate: map[columnReleaseDate],
      title: map[columnTitle],
      video: map[columnVideo] == true ? 1 : 0,
      voteAverage: map[columnVoteAverage],
      voteCount: map[columnVoteCount],
    );
  }

  Favorite copyWith({
    int? id,
    int? adult,
    String? backdropPath,
    int? movieId,
    String? mediaType,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    int? video,
    double? voteAverage,
    int? voteCount,
  }) {
    return Favorite(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      movieId: movieId ?? this.movieId,
      mediaType: mediaType ?? this.mediaType,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}

class FavoriteProvider {
  Database? db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableFavorite ( 
  $columnId integer primary key autoincrement, 
  $columnAdult integer not null,
  $columnBackdropPath text not null,
  $columnMovieId integer not null,
  $columnMediaType text not null,
  $columnOriginalLanguage text not null,
  $columnOriginalTitle text not null,
  $columnOverview text not null,
  $columnPopularity double not null,
  $columnPosterPath text not null,
  $columnReleaseDate text not null,
  $columnTitle text not null,
  $columnVideo integer not null,
  $columnVoteAverage double not null,
  $columnVoteCount integer not null
  );

''');
    });
  }

  Future<Favorite> insert(Map<String, dynamic> favorite) async {
    final id = await db?.insert(tableFavorite, favorite);
    return Favorite.fromMap(favorite..[columnId] = id);
  }

  Future<Favorite?> getFavoriteById(int id) async {
    List<Map> maps =
        await db!.query(tableFavorite, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Favorite.fromMap(maps.first);
    }
    return null;
  }

  Future<Favorite?> getFavoriteByMovieId(int id) async {
    List<Map> maps = await db!
        .query(tableFavorite, where: '$columnMovieId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Favorite.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Favorite>> getFavorites() async {
    if (db == null) {
      await open('db');
    }
    List<Map> maps = await db!.query(tableFavorite);
    if (maps.length > 0) {
      return maps.map<Favorite>((e) => Favorite.fromMap(e)).toList();
    }
    return [];
  }

  Future<int?> delete(int id) async {
    return await db
        ?.delete(tableFavorite, where: '$columnMovieId = ?', whereArgs: [id]);
  }

  Future<int?> update(Favorite favorite) async {
    return await db?.update(tableFavorite, favorite.toMap(),
        where: '$columnMovieId = ?', whereArgs: [favorite.id]);
  }

  Future close() async => db?.close();
}
