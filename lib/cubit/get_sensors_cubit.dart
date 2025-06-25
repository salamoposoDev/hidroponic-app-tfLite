import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hidroponik_app2/model/sensors.dart';
import 'package:meta/meta.dart';

part 'get_sensors_state.dart';

class GetSensorsCubit extends Cubit<GetSensorsState> {
  final dbRef = FirebaseDatabase.instance.ref('sensors');
  GetSensorsCubit() : super(GetSensorsInitial());

  void fetchData() {
    emit(GetSensorsInitial());

    dbRef.onValue.listen(
      (event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          try {
            final log = SensorsModel.fromJson(Map<String, dynamic>.from(data));
            emit(GetSensorsLoaded(sensorsModel: log));
          } catch (e) {
            emit(
              GetSensorsError(error: "Failed to parse data: ${e.toString()}"),
            );
          }
        } else {
          emit(GetSensorsError(error: "No data found"));
        }
      },
      onError: (error) {
        emit(GetSensorsError(error: "Firebase Error: ${error.toString()}"));
      },
    );
  }
}
