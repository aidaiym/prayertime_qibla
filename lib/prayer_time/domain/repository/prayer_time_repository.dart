import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';

abstract class PrayerTimeRepository {
  Future<PrayerTimesEntity> getPrayerTimes(
    double latitude,
    double longitude,
  );
}
