import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/cubit/get_jadwal_cubit.dart';

class JadwalNutrisi extends StatefulWidget {
  const JadwalNutrisi({super.key});

  @override
  State<JadwalNutrisi> createState() => _JadwalNutrisiState();
}

class _JadwalNutrisiState extends State<JadwalNutrisi> {
  List jadwalItem = ['A', 'B', 'C', 'D'];

  TimeOfDay selectedTime = TimeOfDay.now();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseDatabase.instance.ref('/jadwal');
    // ref.onValue.listen((event) {
    //   log(event.snapshot.value.toString());
    // });
    return BlocProvider(
      create: (context) => GetJadwalCubit()..getData(),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jadwal Nutrisi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.h,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close),
                ),
              ],
            ),

            BlocBuilder<GetJadwalCubit, GetJadwalState>(
              builder: (context, state) {
                if (state is GetJadwalEmpty) {
                  return Text('Tidak Ada Data');
                }
                if (state is GetJadwalError) {
                  return Text(state.error);
                }
                if (state is GetJadwalData) {
                  final jadwal = [
                    state.jadwal.a,
                    state.jadwal.b,
                    state.jadwal.c,
                    state.jadwal.d,
                  ];
                  return GridView.builder(
                    itemCount: jadwal.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      mainAxisExtent: 100.h,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          pickTime(context, index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${jadwalItem[index]}: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                jadwal[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Text('error tidak diketahui');
              },
            ),
            // Row(
            //   spacing: 12,
            //   children: [
            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () {
            //           // log(
            //           //   '${indexJadwal[selectedIndex]} ${selectedTime.hour}:${selectedTime.minute}',
            //           // );
            //         },
            //         child: Text(
            //           'Save',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.blue,
            //           fixedSize: Size(double.maxFinite, 40),
            //         ),
            //       ),
            //     ),

            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () => Navigator.pop(context),
            //         child: Text(
            //           'Cancel',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.red,
            //           fixedSize: Size(double.maxFinite, 40),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> pickTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    // log('ready to get time');
    if (picked != null) {
      log(selectedTime.toString());
      setState(() {
        selectedTime = picked;
        selectedIndex = index;
      });
      // Konversi TimeOfDay ke DateTime hari ini
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      // Timestamp hanya dari jam dan menit (dalam detik)
      final timeOnlyTimestamp =
          selectedDateTime.hour * 3600 + selectedDateTime.minute * 60;
      log(timeOnlyTimestamp.toString());
      // log('update jadwal');
      List indexJadwal = ['a', 'b', 'c', 'd'];
      context.read<GetJadwalCubit>().updateJadwal(
        indexJadwal[selectedIndex].toString(),
        '${selectedTime.hour}:${selectedTime.minute}',
        timeOnlyTimestamp,
      );
    } else {
      log('error pick time');
    }
  }
}
