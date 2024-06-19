// import 'package:flutter/material.dart';
// import 'package:flutter_qiblah/flutter_qiblah.dart';
// import 'package:prayer_time_qubla/loading_indicator.dart';
// import 'package:prayer_time_qubla/pray_times.dart';
// import 'package:prayer_time_qubla/qiblah_compass.dart';
// import 'package:prayer_time_qubla/qiblah_maps.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: MainPage());
//   }
// }

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Prayer Time, Qybla'),
//         actions: [
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const PrayTimes()),
//                 );
//               },
//               child: const Text('namaz')),
//         ],
//       ),
//       body: FutureBuilder(
//         future: deviceSupport,
//         builder: (_, AsyncSnapshot<bool?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const LoadingIndicator();
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error.toString()}"),
//             );
//           }

//           if (snapshot.data!) {
//             return const QiblahCompass();
//           } else {
//             return const QiblahMaps();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_time_qubla/core/core.dart';
import 'package:prayer_time_qubla/home_page.dart';
import 'package:prayer_time_qubla/prayer_time/prayer_time.dart';
import 'package:prayer_time_qubla/qibla/qibla.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrayerTimesCubit(
            getPrayerTimes: GetPrayerTimes(
              PrayerTimeRepositoryImpl(
                remoteDataSource: PrayerTimeRemoteDataSource(RemoteClient()),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => QiblaCubit(
            GetQiblaDirection(
              QiblaRepositoryImpl(
                remoteDataSource:
                    QiblaRemoteDataSource(remoteClient: RemoteClient()),
              ),
            ),
          ),
        ),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
