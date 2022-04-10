// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMovies _$ResponseMoviesFromJson(Map<String, dynamic> json) =>
    ResponseMovies(
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseMoviesToJson(ResponseMovies instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
