import 'package:movie_app/data/model/genre.dart';
import 'package:movie_app/data/model/movie_detail.dart';
import 'package:movie_app/utils/use_me.dart';

class MovieDetailUi {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  String genresString;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;

  String productionCountries;
  int releaseYear;
  String releaseDateString;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailUi({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genresString,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCountries,
    required this.releaseYear,
    required this.releaseDateString,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailUi.fromModel(MovieDetail movieDetail) {
    String genresString =
        movieDetail.genres.map((genre) => genre.name).join(", ");
    String productionCountries = movieDetail.productionCountries
        .map((country) => country["name"])
        .join(", ");

    String releaseDateString = UseMe.getDateString(movieDetail.releaseDate);

    int releaseYear = movieDetail.releaseDate.year;

    return MovieDetailUi(
      adult: movieDetail.adult,
      backdropPath: movieDetail.backdropPath,
      belongsToCollection: movieDetail.belongsToCollection,
      budget: movieDetail.budget,
      genresString: genresString,
      genres: movieDetail.genres,
      homepage: movieDetail.homepage,
      id: movieDetail.id,
      imdbId: movieDetail.imdbId,
      originalLanguage: movieDetail.originalLanguage,
      originalTitle: movieDetail.originalTitle,
      overview: movieDetail.overview,
      popularity: movieDetail.popularity,
      posterPath: movieDetail.posterPath,
      productionCountries: productionCountries,
      releaseYear: releaseYear,
      releaseDateString: releaseDateString,
      revenue: movieDetail.revenue,
      runtime: movieDetail.runtime,
      status: movieDetail.status,
      tagline: movieDetail.tagline,
      title: movieDetail.title,
      video: movieDetail.video,
      voteAverage: movieDetail.voteAverage,
      voteCount: movieDetail.voteCount,
    );
  }
}
