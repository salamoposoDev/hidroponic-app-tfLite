import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/cubit/get_plant_age_cubit.dart';
import 'package:intl/intl.dart';

class InfoBanner extends StatefulWidget {
  const InfoBanner({super.key});

  @override
  State<InfoBanner> createState() => _InfoBannerState();
}

class _InfoBannerState extends State<InfoBanner> {
  DateFormat format = DateFormat('EEEE, dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseDatabase.instance.ref('plant/settings');
    // ref.onValue.listen((event) {
    //   String data = event.snapshot.value.toString();
    //   log(data);
    // });

    return BlocProvider(
      create: (context) => GetPlantAgeCubit()..loadTanaman(),
      child: BlocBuilder<GetPlantAgeCubit, GetPlantAgeState>(
        builder: (context, state) {
          if (state is GetPlantAgeLoaded) {
            final dayOne = DateTime.parse(
              state.settingTanamanData.tanggalTanam,
            );
            int age = hitungUmurTanaman(dayOne);
            return Container(
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(-3.h, 3.h),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.rotate(
                    angle: 90,
                    child: Image.asset(
                      plantImage(state.settingTanamanData.plantStr),
                      height: 100,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.settingTanamanData.plantStr,
                        style: TextStyle(
                          fontSize: 24.h,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 113, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Hari ke $age',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.h,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Fase ${getFaseTanaman(age)}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14.h,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          getKondisiPanen(age),
                          style: TextStyle(
                            color: Colors.orange.shade600,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 0),
                ],
              ),
            );
          }
          return Text('something wrong');
        },
      ),
    );
  }
}

String plantImage(String name) {
  switch (name) {
    case 'Kangkung':
      return 'assets/kangkung.png';
    case 'Selada':
      return 'assets/selada.png';
    case 'Bayam':
      return 'assets/bayam.png';
    case 'Pakcoy':
      return 'assets/pakcoy_.png';

    default:
      return 'assets/bayam.png';
  }
}

int hitungUmurTanaman(DateTime tanamDate) {
  final now = DateTime.now();
  final difference = now.difference(tanamDate).inDays;
  log('Umur tanaman = $difference hari');
  return difference;
}

String getFaseTanaman(int umurTanaman) {
  if (umurTanaman >= 0 && umurTanaman <= 7) {
    return 'Pembibitan'; // Fase Pembibitan
  } else if (umurTanaman >= 8 && umurTanaman <= 21) {
    return 'Remaja'; // Fase Remaja
  } else if (umurTanaman >= 22) {
    return 'Dewasa'; // Fase Dewasa
  } else {
    return 'Tidak Valid'; // Jika umur tidak valid
  }
}

String getKondisiPanen(int umurTanaman) {
  if (umurTanaman >= 0 && umurTanaman <= 25) {
    return 'Belum Siap Panen';
  } else if (umurTanaman >= 26 && umurTanaman <= 34) {
    return 'Hampir Siap Panen';
  } else if (umurTanaman >= 35) {
    return 'Siap Panen';
  } else {
    return 'Tidak Valid';
  }
}
