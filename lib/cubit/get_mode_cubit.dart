import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_mode_state.dart';

class GetModeCubit extends Cubit<int> {
  final dbRef = FirebaseDatabase.instance.ref("/mode");
  GetModeCubit() : super(0);

  void getMode() {
    try {
      dbRef.onValue.listen((event) {
        if (event.snapshot.exists) {
          final value = event.snapshot.value as int;
          emit(value);
        }
      });
    } catch (e) {}
  }

  void setMode(int val) {
    dbRef.set(val);
    getMode();
  }
}
