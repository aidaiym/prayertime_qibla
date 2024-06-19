import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_time_qubla/qibla/qibla.dart';
part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  final GetQiblaDirection getQiblaDirection;

  QiblaCubit(this.getQiblaDirection) : super(QiblaInitial());

  Future<void> fetchQiblaDirection(double latitude, double longitude) async {
    emit(QiblaLoading());
    try {
      final qiblaDirection = await getQiblaDirection(latitude, longitude);
      emit(QiblaLoaded(qiblaDirection));
    } catch (e) {
      emit(QiblaError('Failed to fetch Qibla direction: $e'));
    }
  }
}