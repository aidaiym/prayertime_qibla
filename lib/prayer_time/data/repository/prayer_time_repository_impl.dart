import 'package:flutter/foundation.dart';
import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';

@immutable
final class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  const PrayerTimeRepositoryImpl({required this.remoteDataSource});

  final PrayerTimeRemoteDataSource remoteDataSource;

  @override
  Future<PrayerTimesEntity> getPrayerTimes(
    double latitude,
    double longitude,

  ) async {
    final model = await remoteDataSource.getPrayerTimes(
      latitude,
      longitude,

    );
    return _convertData(
      PrayerTimesResponse(
        fajr: model.fajr,
        dhuhr: model.dhuhr,
        asr: model.asr,
        maghrib: model.maghrib,
        isha: model.isha,
      ),
    );
  }

  PrayerTimesEntity _convertData(PrayerTimesResponse response) {
    return PrayerTimesEntity(
        fajr: response.fajr,
        asr: response.asr,
        dhuhr: response.dhuhr,
        maghrib: response.maghrib,
        isha: response.isha);
  }
}
