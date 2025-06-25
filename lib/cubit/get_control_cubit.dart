import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hidroponik_app2/model/control_model.dart';
import 'package:meta/meta.dart';

part 'get_control_state.dart';

class GetControlCubit extends Cubit<GetControlState> {
  final ref = FirebaseDatabase.instance.ref('/pump');
  GetControlCubit() : super(GetControlInitial());

  void getPumpStatus() {
    emit(GetControlInitial());

    try {
      ref.onValue.listen((event) {
        if (event.snapshot.exists) {
          final data = event.snapshot.value as Map<dynamic, dynamic>?;
          final mapData = ControlModel.fromJson(
            Map<String, dynamic>.from(data!),
          );
          emit(GetControlData(controlModel: mapData));
        } else {
          emit(GetControlEmpty());
        }
      });
    } catch (e) {
      emit(GetControlError(error: e.toString()));
    }
  }

  Future<void> updateSingleField(String key, int value) async {
    // emit(GetControlInitial());
    try {
      await ref.update({key: value});
      // getPumpStatus(); // refresh after update
      await Future.delayed(Duration(seconds: 5));
      await ref.update({key: 0});
      // getPumpStatus();
    } catch (e) {
      emit(GetControlError(error: e.toString()));
    }
  }
}
