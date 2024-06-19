import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prayer_time_qubla/qibla/qibla.dart';

class QiblaView extends StatefulWidget {
  final double latitude;
  final double longitude;

  const QiblaView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  // ignore: library_private_types_in_public_api
  _QiblaViewState createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  @override
  void initState() {
    super.initState();
    // Fetch Qibla direction when view is initialized
    context.read<QiblaCubit>().fetchQiblaDirection(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Direction'),
      ),
      body: BlocBuilder<QiblaCubit, QiblaState>(
        builder: (context, state) {
          if (state is QiblaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QiblaLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Qibla Direction: ${state.qiblaDirection.direction}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<QiblaCubit>().fetchQiblaDirection(widget.latitude, widget.longitude);
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          } else if (state is QiblaError) {
            log(state.message);
            return Center(
              child: Text(state.message),

            );
          } else {
            return const Center(
              child: Text('Press the button to fetch Qibla direction'),
            );
          }
        },
      ),
    );
  }
}
