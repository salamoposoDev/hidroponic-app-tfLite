part of 'get_pump_history_cubit.dart';

@immutable
sealed class GetPumpHistoryState {}

final class GetPumpHistoryLoading extends GetPumpHistoryState {}

final class GetPumpHistoryLoded extends GetPumpHistoryState {
  final List<PumpHistoryModel> pumpHistory;

  GetPumpHistoryLoded({required this.pumpHistory});
}

final class GetPumpHistoryError extends GetPumpHistoryState {
  final String error;

  GetPumpHistoryError({required this.error});
}

final class GetPumpHistoryEmpty extends GetPumpHistoryState {}
