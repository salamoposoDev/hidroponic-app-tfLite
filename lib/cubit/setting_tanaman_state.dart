part of 'setting_tanaman_cubit.dart';

@immutable
sealed class SettingTanamanState {}

class TanamanInitial extends SettingTanamanState {}

class TanamanLoading extends SettingTanamanState {}

class TanamanLoaded extends SettingTanamanState {
  final SettingTanamanModel data;

  TanamanLoaded(this.data);
}

class TanamanError extends SettingTanamanState {
  final String message;

  TanamanError(this.message);
}
