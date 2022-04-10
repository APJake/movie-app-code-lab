import 'package:json_annotation/json_annotation.dart';

part 'crew.g.dart';

@JsonSerializable()
class Crew {
  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  bool adult;
  int gender;
  int id;
  @JsonKey(name: "known_for_department")
  String knownForDepartment;
  String name;
  @JsonKey(name: "original_name")
  String originalName;
  double popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;
  @JsonKey(name: "credit_id")
  String creditId;
  String department;
  String job;

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
