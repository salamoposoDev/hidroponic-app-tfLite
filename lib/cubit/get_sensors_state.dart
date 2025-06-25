part of 'get_sensors_cubit.dart';

@immutable
sealed class GetSensorsState {}

final class GetSensorsInitial extends GetSensorsState {}

final class GetSensorsError extends GetSensorsState {
  final String error;

  GetSensorsError({required this.error});
}

final class GetSensorsEmpty extends GetSensorsState {}

final class GetSensorsLoaded extends GetSensorsState {
  final SensorsModel sensorsModel;

  GetSensorsLoaded({required this.sensorsModel});
}
