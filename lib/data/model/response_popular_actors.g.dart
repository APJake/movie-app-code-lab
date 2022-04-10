// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_popular_actors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePopularActors _$ResponsePopularActorsFromJson(
        Map<String, dynamic> json) =>
    ResponsePopularActors(
      results: (json['results'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponsePopularActorsToJson(
        ResponsePopularActors instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
