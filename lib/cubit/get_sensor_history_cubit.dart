import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hidroponik_app2/model/sensor_log_model.dart';
import 'package:meta/meta.dart';

part 'get_sensor_history_state.dart';

class GetSensorHistoryCubit extends Cubit<GetSensorHistoryState> {
  final dbRef = FirebaseDatabase.instance.ref('history/sensors');
  GetSensorHistoryCubit() : super(GetSensorHistoryInitial());

  Future<void> getData() async {
    // emit(GetPumpHistoryLoading());
    try {
      final snapshot = await dbRef.get();
      final raw = snapshot.value as Map<Object?, Object?>;

      final historyList =
          raw.entries.map((entry) {
            final id = entry.key.toString();
            final value = Map<String, dynamic>.from(
              entry.value as Map,
            ); // solusi casting aman
            return SensorLogModel.fromJson(id, value);
          }).toList();
      historyList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      emit(GetSensorHistoryLoaded(dataHistory: historyList));

      // Gunakan historyList
    } catch (e) {
      log('eror get history sensor $e');
      emit(GetSensorHistoryError(error: e.toString()));
    }
  }
}
