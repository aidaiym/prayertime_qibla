

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';

class PrayerTimesView extends StatefulWidget {
  final double latitude;
  final double longitude;


  const PrayerTimesView({
    super.key,
    required this.latitude,
    required this.longitude,

  });

  @override
  // ignore: library_private_types_in_public_api
  _PrayerTimesViewState createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  late final String date = DateTime.now().toString(); // You can format this as required

  @override
  void initState() {
    super.initState();
    context.read<PrayerTimesCubit>().fetchPrayerTimes(
          widget.latitude,
          widget.longitude,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
      ),
      body: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        builder: (context, state) {
          if (state is PrayerTimesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PrayerTimesLoaded) {
            return _buildPrayerTimesList(state.prayerTimes);
          } else if (state is PrayerTimesError) {
            log(state.message.toString());
            return Center(
              child: Text(state.message.toString()),
            );
          } else {
            return const Center(
              child:  Text('Press the button to fetch prayer times'),
            );
          }
        },
      ),
    );
  }

  Widget _buildPrayerTimesList(PrayerTimesEntity prayerTimes) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPrayerTimeItem('Fajr', prayerTimes.fajr.toString()),
        _buildPrayerTimeItem('Dhuhr', prayerTimes.dhuhr.toString()),
        _buildPrayerTimeItem('Asr', prayerTimes.asr.toString()),
        _buildPrayerTimeItem('Maghrib', prayerTimes.maghrib.toString()),
        _buildPrayerTimeItem('Isha', prayerTimes.isha.toString()),
      ],
    );
  }

  Widget _buildPrayerTimeItem(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(time),
        ],
      ),
    );
  }
}
