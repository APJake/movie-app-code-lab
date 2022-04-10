// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_genres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGenres _$ResponseGenresFromJson(Map<String, dynamic> json) =>
    ResponseGenres(
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGenresToJson(ResponseGenres instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };
