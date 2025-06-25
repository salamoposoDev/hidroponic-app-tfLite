part of 'get_control_cubit.dart';

@immutable
sealed class GetControlState {}

final class GetControlInitial extends GetControlState {}

final class GetControlEmpty extends GetControlState {}

final class GetControlError extends GetControlState {
  final String error;

  GetControlError({required this.error});
}

final class GetControlData extends GetControlState {
  final ControlModel controlModel;

  GetControlData({required this.controlModel});
}
