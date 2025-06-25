part of 'get_jadwal_cubit.dart';

@immutable
sealed class GetJadwalState {}

final class GetJadwalInitial extends GetJadwalState {}

final class GetJadwalError extends GetJadwalState {
  final String error;

  GetJadwalError({required this.error});
}

final class GetJadwalEmpty extends GetJadwalState {}

final class GetJadwalData extends GetJadwalState {
  final JadwalModel jadwal;

  GetJadwalData({required this.jadwal});
}
