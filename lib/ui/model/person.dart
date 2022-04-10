import 'package:movie_app/data/model/cast.dart';
import 'package:movie_app/data/model/crew.dart';

class Person {
  Person({
    required this.gender,
    required this.id,
    required this.name,
    required this.profilePath,
  });
  String name;
  int gender;
  int id;
  String? profilePath;

  factory Person.fromCast(Cast cast) => Person(
      gender: cast.gender,
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath);
  factory Person.fromCrew(Crew crew) => Person(
      gender: crew.gender,
      id: crew.id,
      name: crew.name,
      profilePath: crew.profilePath);
}
