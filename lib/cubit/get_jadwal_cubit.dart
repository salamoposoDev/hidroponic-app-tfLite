import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:hidroponik_app2/model/jadwal.dart';
import 'package:meta/meta.dart';

part 'get_jadwal_state.dart';

class GetJadwalCubit extends Cubit<GetJadwalState> {
  final ref = FirebaseDatabase.instance.ref('/jadwal');
  GetJadwalCubit() : super(GetJadwalInitial());

  void getData() async {
    emit(GetJadwalInitial());
    try {
      final snapshot = await ref.child('jadwalStr/').get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final log = JadwalModel.fromJson(data);
        emit(GetJadwalData(jadwal: log));
      } else {
        emit(GetJadwalEmpty());
      }
    } catch (e) {
      emit(GetJadwalError(error: e.toString()));
    }
  }

  Future<void> updateJadwal(String key, String valueStr, int valInt) async {
    emit(GetJadwalInitial());

    try {
      await ref.child('jadwalStr/').update({key: valueStr});
      await ref.child('jadwalInt/').update({key: valInt});

      // Setelah update, ambil data terbaru
      getData();
    } catch (e) {
      emit(GetJadwalError(error: e.toString()));
    }
  }
}
