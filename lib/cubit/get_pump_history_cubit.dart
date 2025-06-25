import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hidroponik_app2/model/pump_history_model.dart';
import 'package:meta/meta.dart';

part 'get_pump_history_state.dart';

class GetPumpHistoryCubit extends Cubit<GetPumpHistoryState> {
  final dbRef = FirebaseDatabase.instance.ref('history/predictResult/');
  GetPumpHistoryCubit() : super(GetPumpHistoryLoading());

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
            return PumpHistoryModel.fromJson(id, value);
          }).toList();
      historyList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      emit(GetPumpHistoryLoded(pumpHistory: historyList));

      // Gunakan historyList
    } catch (e) {
      log(e.toString());
      emit(GetPumpHistoryError(error: e.toString()));
    }
  }
}
