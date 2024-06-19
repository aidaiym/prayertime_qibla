import 'package:flutter/material.dart';

import 'prayer_time/prayer_time.dart';
import 'qibla/qibla.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrayerTimesView(
                      latitude: 25.4106386,
                      longitude: 51.1846025,
                    ),
                  ),
                );
              },
              child: const Text('Go to Prayer Times'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QiblaView(
                      latitude: 25.4106386,
                      longitude: 51.1846025,
                    ),
                  ),
                );
              },
              child: const Text('Go to Qibla Direction'),
            ),
          ],
        ),
      ),
    );
  }
}
