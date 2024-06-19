import 'package:flutter/material.dart';
import 'package:prayer_time_qubla/data.dart';
import 'package:prayer_time_qubla/json_connection.dart';

class PrayTimes extends StatefulWidget {
  const PrayTimes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrayTimesState createState() => _PrayTimesState();
}

class _PrayTimesState extends State<PrayTimes> {
  JsonConnection jsonConnection = JsonConnection();
  Data? list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pray Times'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: jsonConnection.getPTLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text('Fajr'),
                          Text('Dhuhr'),
                          Text('Asr'),
                          Text('Maghrib'),
                          Text('Isha'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(snapshot.data.data.timings.fajr),
                          Text(snapshot.data.data.timings.dhuhr),
                          Text(snapshot.data.data.timings.asr),
                          Text(snapshot.data.data.timings.maghrib),
                          Text(snapshot.data.data.timings.isha),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
