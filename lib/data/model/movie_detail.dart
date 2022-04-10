import 'package:json_annotation/json_annotation.dart';

import 'genre.dart';

part 'movie_detail.g.dart';

@JsonSerializable()
class MovieDetail {
  bool adult;
  @JsonKey(name: "backdrop_path")
  String backdropPath;
  @JsonKey(name: "belongs_to_collection")
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  @JsonKey(name: "imdb_id")
  String imdbId;
  @JsonKey(name: "original_language")
  String originalLanguage;
  @JsonKey(name: "original_title")
  String originalTitle;
  String overview;
  double popularity;
  @JsonKey(name: "poster_path")
  String posterPath;
  @JsonKey(name: "production_companies")
  List<dynamic> productionCompanies;
  @JsonKey(name: "production_countries")
  List<dynamic> productionCountries;
  @JsonKey(name: "release_date")
  DateTime releaseDate;
  int revenue;
  int runtime;
  @JsonKey(name: "spoken_languages")
  List<dynamic> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  @JsonKey(name: "vote_average")
  double voteAverage;
  @JsonKey(name: "vote_count")
  int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}
