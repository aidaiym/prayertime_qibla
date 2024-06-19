import 'package:prayer_time_qubla/qibla/qibla.dart';

class QiblaRepositoryImpl implements QiblaDirectionRepository {
  final QiblaRemoteDataSource remoteDataSource;

  QiblaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<QiblaDirectionEntity> getQiblaDirection(
      double latitude, double longitude) async {
    try {
      final result =
          await remoteDataSource.getQiblaDirection(latitude, longitude);
      return _convertData(result);
    } catch (e) {
      rethrow;
    }
  }

  QiblaDirectionEntity _convertData(QiblaDirectionResponse data) {
    return QiblaDirectionEntity(
        latitude: data.latitude,
        longitude: data.longitude,
        direction: data.direction);
  }
}
