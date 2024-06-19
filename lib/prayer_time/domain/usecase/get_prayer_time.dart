import 'package:flutter/foundation.dart';
import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';

@immutable
final class GetPrayerTimes {
  final PrayerTimeRepository repository;

  const GetPrayerTimes(this.repository);

  Future<PrayerTimesEntity> call(
    double latitude,
    double longitude,

  ) async {
    return await repository.getPrayerTimes(
      latitude,
      longitude,
    );
  }
}
