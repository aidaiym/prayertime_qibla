import 'package:flutter/foundation.dart';
import 'package:prayer_time_qubla/qibla/qibla.dart';

@immutable
final  class GetQiblaDirection {
  final QiblaDirectionRepository repository;

  const GetQiblaDirection(this.repository);

  Future<QiblaDirectionEntity> call(double latitude, double longitude) async {
    return await repository.getQiblaDirection(latitude, longitude);
  }
}
