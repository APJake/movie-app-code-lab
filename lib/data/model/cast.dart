import 'package:json_annotation/json_annotation.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
    this.originalName,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });
  bool adult;
  int gender;
  int id;

  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  String name;
  double popularity;

  @JsonKey(name: "profile_path")
  String? profilePath;

  @JsonKey(name: "original_name")
  String? originalName;

  @JsonKey(name: "cast_id")
  int? castId;
  String? character;

  @JsonKey(name: "credit_id")
  String? creditId;
  int? order;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
