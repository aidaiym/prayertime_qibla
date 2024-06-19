// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayerTimesResponse _$PrayerTimesFromJson(Map<String, dynamic> json) => PrayerTimesResponse(
      fajr: DateTime.parse(json['fajr'] as String),
      dhuhr: DateTime.parse(json['dhuhr'] as String),
      asr: DateTime.parse(json['asr'] as String),
      maghrib: DateTime.parse(json['maghrib'] as String),
      isha: DateTime.parse(json['isha'] as String),
    );

Map<String, dynamic> _$PrayerTimesToJson(PrayerTimesResponse instance) =>
    <String, dynamic>{
      'fajr': instance.fajr.toIso8601String(),
      'dhuhr': instance.dhuhr.toIso8601String(),
      'asr': instance.asr.toIso8601String(),
      'maghrib': instance.maghrib.toIso8601String(),
      'isha': instance.isha.toIso8601String(),
    };
