import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hidroponik_app2/cubit/setting_tanaman_cubit.dart';
import 'package:hidroponik_app2/model/setting_tanaman.dart';

part 'get_plant_age_state.dart';

class GetPlantAgeCubit extends Cubit<GetPlantAgeState> {
  final dbRef = FirebaseDatabase.instance.ref('plant/settings');
  GetPlantAgeCubit() : super(GetPlantAgeLoading());

  Future<void> loadTanaman() async {
    try {
      dbRef.onValue.listen((event) {
        if (event.snapshot.exists) {
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          final tanaman = SettingTanamanModel.fromJson(data);
          emit(GetPlantAgeLoaded(settingTanamanData: tanaman));
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
