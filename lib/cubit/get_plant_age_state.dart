part of 'get_plant_age_cubit.dart';

sealed class GetPlantAgeState {}

final class GetPlantAgeLoading extends GetPlantAgeState {}

final class GetPlantAgeLoaded extends GetPlantAgeState {
  final SettingTanamanModel settingTanamanData;

  GetPlantAgeLoaded({required this.settingTanamanData});
}
