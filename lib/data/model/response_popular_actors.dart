import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/model/cast.dart';
part 'response_popular_actors.g.dart';

@JsonSerializable()
class ResponsePopularActors {
  List<Cast> results;

  ResponsePopularActors({
    required this.results,
  });

  factory ResponsePopularActors.fromJson(Map<String, dynamic> json) =>
      _$ResponsePopularActorsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePopularActorsToJson(this);
}
