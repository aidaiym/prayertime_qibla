// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qibla_direction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QiblaDirectionResponse _$QiblaDirectionFromJson(Map<String, dynamic> json) =>
    QiblaDirectionResponse(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      direction: (json['direction'] as num).toDouble(),
    );

Map<String, dynamic> _$QiblaDirectionToJson(QiblaDirectionResponse instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'direction': instance.direction,
    };
