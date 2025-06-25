import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hidroponik_app2/model/setting_tanaman.dart';
import 'package:meta/meta.dart';

part 'setting_tanaman_state.dart';

class SettingTanamanCubit extends Cubit<SettingTanamanState> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref(
    'plant/settings',
  );

  SettingTanamanCubit() : super(TanamanInitial());

  Future<void> loadTanaman() async {
    emit(TanamanLoading());
    try {
      final snapshot = await _dbRef.get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final tanaman = SettingTanamanModel.fromJson(data);
        emit(TanamanLoaded(tanaman));
      }
    } catch (e) {
      emit(TanamanError('Gagal memuat data: $e'));
    }
  }

  Future<void> setTanaman(SettingTanamanModel tanaman) async {
    try {
      await _dbRef.set(tanaman.toJson());
      await loadTanaman(); // refresh data
    } catch (e) {
      emit(TanamanError('Gagal menambahkan data: $e'));
    }
  }
}
