import 'package:flutter/material.dart';
import 'package:prayer_time_qubla/core/core.dart';
import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';

@immutable
final class PrayerTimeRemoteDataSource {
  const PrayerTimeRemoteDataSource(this.client);

  final RemoteClient client;

  Future<PrayerTimesResponse> getPrayerTimes(
      double latitude, double longitude,) async {

    final url =
        'http://api.aladhan.com/v1/timings/17-07-2007?latitude=$latitude&longitude=$longitude&method=3';
    final response = await client.get(url);
    return response['data']['timings'];
  }
}
