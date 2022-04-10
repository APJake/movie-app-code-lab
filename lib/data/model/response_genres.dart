import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/model/genre.dart';

part 'response_genres.g.dart';

@JsonSerializable()
class ResponseGenres {
  List<Genre> genres;
  ResponseGenres({
    required this.genres,
  });

  factory ResponseGenres.fromJson(Map<String, dynamic> json) =>
      _$ResponseGenresFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGenresToJson(this);
}
