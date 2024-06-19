// models/qibla_direction.dart
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qibla_direction.g.dart';

@JsonSerializable()
@immutable
final class QiblaDirectionResponse {
  const QiblaDirectionResponse({
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  factory QiblaDirectionResponse.fromJson(Map<String, dynamic> json) => _$QiblaDirectionFromJson(json);
  Map<String, dynamic> toJson() => _$QiblaDirectionToJson(this);

  final double latitude;
  final double longitude;
  final double direction;
}
