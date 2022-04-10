import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/model/crew.dart';

import 'cast.dart';
part 'response_credits.g.dart';

@JsonSerializable()
class ResponseCredits {
  List<Cast> cast;
  List<Crew> crew;
  ResponseCredits({
    required this.cast,
    required this.crew,
  });

  factory ResponseCredits.fromJson(Map<String, dynamic> json) =>
      _$ResponseCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCreditsToJson(this);
}
