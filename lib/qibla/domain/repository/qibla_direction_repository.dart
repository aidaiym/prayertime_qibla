import 'package:prayer_time_qubla/qibla/qibla.dart';

abstract class QiblaDirectionRepository {
  Future<QiblaDirectionEntity> getQiblaDirection(
    double latitude,
    double longitude,
  );
}
