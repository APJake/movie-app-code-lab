// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCredits _$ResponseCreditsFromJson(Map<String, dynamic> json) =>
    ResponseCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseCreditsToJson(ResponseCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
    };
