
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayerTimes getPrayerTimes;

  PrayerTimesCubit({required this.getPrayerTimes}) : super( PrayerTimesInitial());

  void fetchPrayerTimes(double latitude, double longitude) async {
    emit(PrayerTimesLoading());
    try {
      final prayerTimes = await getPrayerTimes(latitude, longitude);
      log(prayerTimes.toString());
      emit(PrayerTimesLoaded(prayerTimes));
    } catch (e) {
      emit(const PrayerTimesError('Failed to fetch prayer times.'));
    }
  }
}
