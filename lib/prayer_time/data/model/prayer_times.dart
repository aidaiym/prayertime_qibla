import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prayer_times.g.dart';

@JsonSerializable()
@immutable
final class PrayerTimesResponse {
  const PrayerTimesResponse({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimesFromJson(json);

  Map<String, dynamic> toJson() => _$PrayerTimesToJson(this);

  final DateTime fajr;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
}
