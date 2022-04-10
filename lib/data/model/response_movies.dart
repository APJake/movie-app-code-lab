import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/model/movie.dart';

part 'response_movies.g.dart';

@JsonSerializable()
class ResponseMovies {
  List<Movie> results;
  ResponseMovies({
    required this.results,
  });

  factory ResponseMovies.fromJson(Map<String, dynamic> json) =>
      _$ResponseMoviesFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMoviesToJson(this);
}
