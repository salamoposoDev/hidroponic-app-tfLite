part of 'get_sensor_history_cubit.dart';

@immutable
sealed class GetSensorHistoryState {}

final class GetSensorHistoryInitial extends GetSensorHistoryState {}

final class GetSensorHistoryEmpty extends GetSensorHistoryState {}

final class GetSensorHistoryError extends GetSensorHistoryState {
  final String error;

  GetSensorHistoryError({required this.error});
}

final class GetSensorHistoryLoaded extends GetSensorHistoryState {
  final List<SensorLogModel> dataHistory;

  GetSensorHistoryLoaded({required this.dataHistory});
}
