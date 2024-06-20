import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time_qubla/components/components.dart';
import 'package:prayer_time_qubla/constants/text_style.dart';
import 'qibla/qibla.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _latitude = '';
  String _longitude = '';
  Map<String, String> _prayerTimes = {
    'Fajr': 'Loading...',
    'Dhuhr': 'Loading...',
    'Asr': 'Loading...',
    'Maghrib': 'Loading...',
    'Isha': 'Loading...',
  };

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      _fetchPrayerTimes();
    });
  }

  void _fetchPrayerTimes() async {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    log(_latitude);
    log(_longitude);

    final url =
        'http://api.aladhan.com/v1/timings/$formattedDate?latitude=$_latitude&longitude=$_longitude&method=3';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final prayerTimes = responseData['data']['timings'];

        setState(() {
          _prayerTimes = {
            'Fajr': prayerTimes['Fajr'],
            'Dhuhr': prayerTimes['Dhuhr'],
            'Asr': prayerTimes['Asr'],
            'Maghrib': prayerTimes['Maghrib'],
            'Isha': prayerTimes['Isha'],
          };
        });
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      log('Error fetching prayer times: $e');
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the initial auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Force a token refresh by signing out and then signing back in
      await _googleSignIn.signOut();
      final GoogleSignInAccount? refreshedGoogleUser =
          await _googleSignIn.signInSilently();
      final GoogleSignInAuthentication refreshedGoogleAuth =
          await refreshedGoogleUser!.authentication;

      // Create a new credential with the refreshed token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: refreshedGoogleAuth.accessToken,
        idToken: refreshedGoogleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF739AFF),
                Color(0xFFFFFFFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () async {
                  User? user = await _signInWithGoogle();
                  if (user != null) {
                    print('Signed in as ${user.displayName}');
                  } else {
                    print('Sign in failed');
                  }
                },
                child: Text('Sign in with Google'),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ассаламу алейкум!',
                              style: AppTextStyle.white10,
                            ),
                            Text(
                              'Асан',
                              style: AppTextStyle.white10,
                            ),
                          ],
                        ),
                        IconButton(
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
                          icon: SvgPicture.asset('assets/gps.svg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xffDADADA),
                height: 0.5,
              ),
              const SizedBox(
                height: 40,
              ),
              const RadialGradientAnimation(),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff626DF5),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (var prayer in _prayerTimes.keys)
                        Column(
                          children: [
                            Text(
                              prayer,
                              style: AppTextStyle.white12w600,
                            ),
                            Text(
                              _prayerTimes[prayer] ?? 'Loading...',
                              style: AppTextStyle.white10,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Хатым',
                    style: AppTextStyle.black20w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffE5EEFF),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Жалпы кылынган Хатым',
                              style: AppTextStyle.primary15w500,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '8',
                              style: AppTextStyle.primary18w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffE5EEFF),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Жалпы окулган беттер',
                              style: AppTextStyle.primary15w500,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '5318',
                              style: AppTextStyle.primary18w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffE5EEFF),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Сиз окуган барактардын саны',
                              style: AppTextStyle.primary15w500,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '100',
                              style: AppTextStyle.primary18w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xff626DF5),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Хатымга катышуу',
                  style: AppTextStyle.white10,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: const Color(0xff626DF5),
        color: const Color(0xffE5EEFF),
        items: const <Widget>[
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}
