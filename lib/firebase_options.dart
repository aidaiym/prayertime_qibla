// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC2TquudJD8x7okb7KZgS_ZGb3HYXLWcAg',
    appId: '1:256699219363:web:3b47e559bd069f3a002e16',
    messagingSenderId: '256699219363',
    projectId: 'quran-test-21de1',
    authDomain: 'quran-test-21de1.firebaseapp.com',
    storageBucket: 'quran-test-21de1.appspot.com',
    measurementId: 'G-DK6ZZYD92M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA--Za3nPZ-pQp5-qqmzBBTr9Xq1FU8XyA',
    appId: '1:256699219363:android:34a9a22efe89f883002e16',
    messagingSenderId: '256699219363',
    projectId: 'quran-test-21de1',
    storageBucket: 'quran-test-21de1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvku31YMJg2chQGp8dUMGO1H4Ent_IFUs',
    appId: '1:256699219363:ios:0a797c5274c248a1002e16',
    messagingSenderId: '256699219363',
    projectId: 'quran-test-21de1',
    storageBucket: 'quran-test-21de1.appspot.com',
    androidClientId: '256699219363-nvbrtt11ilh383omq9v2ffqj6n6s4peb.apps.googleusercontent.com',
    iosClientId: '256699219363-cfc1canh237i15lvct01t0p0u9gv3idf.apps.googleusercontent.com',
    iosBundleId: 'com.example.prayerTimeQubla',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvku31YMJg2chQGp8dUMGO1H4Ent_IFUs',
    appId: '1:256699219363:ios:0a797c5274c248a1002e16',
    messagingSenderId: '256699219363',
    projectId: 'quran-test-21de1',
    storageBucket: 'quran-test-21de1.appspot.com',
    androidClientId: '256699219363-nvbrtt11ilh383omq9v2ffqj6n6s4peb.apps.googleusercontent.com',
    iosClientId: '256699219363-cfc1canh237i15lvct01t0p0u9gv3idf.apps.googleusercontent.com',
    iosBundleId: 'com.example.prayerTimeQubla',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2TquudJD8x7okb7KZgS_ZGb3HYXLWcAg',
    appId: '1:256699219363:web:65243367a93b76e4002e16',
    messagingSenderId: '256699219363',
    projectId: 'quran-test-21de1',
    authDomain: 'quran-test-21de1.firebaseapp.com',
    storageBucket: 'quran-test-21de1.appspot.com',
    measurementId: 'G-36J5BPZMBZ',
  );
}
