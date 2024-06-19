part of 'qibla_cubit.dart';


@immutable
abstract class QiblaState extends Equatable {
  const QiblaState();

  @override
  List<Object?> get props => [];
}

class QiblaInitial extends QiblaState {}

class QiblaLoading extends QiblaState {}

class QiblaLoaded extends QiblaState {
  final QiblaDirectionEntity qiblaDirection;

  const QiblaLoaded(this.qiblaDirection);

  @override
  List<Object?> get props => [qiblaDirection];
}

class QiblaError extends QiblaState {
  final String message;

  const QiblaError(this.message);

  @override
  List<Object?> get props => [message];
}
