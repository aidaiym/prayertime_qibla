import 'package:flutter/foundation.dart';

@immutable
final class QiblaDirectionEntity {
  const QiblaDirectionEntity({
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  final double latitude;
  final double longitude;
  final double direction;
}
