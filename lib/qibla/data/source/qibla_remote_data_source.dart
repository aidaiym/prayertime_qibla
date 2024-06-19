import 'package:prayer_time_qubla/core/core.dart';
import 'package:prayer_time_qubla/qibla/qibla.dart';

class QiblaRemoteDataSource {
  QiblaRemoteDataSource({required this.remoteClient});

  final RemoteClient remoteClient;

  Future<QiblaDirectionResponse> getQiblaDirection(
      double latitude, double longitude) async {
    try {
      final response = await remoteClient.get('/qibla/$latitude/$longitude');
      final data = response['data'] as Map<String, dynamic>;
      return QiblaDirectionResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
