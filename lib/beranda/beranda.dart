import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/beranda/control_banner.dart';
import 'package:hidroponik_app2/beranda/info_banner.dart';
import 'package:hidroponik_app2/cubit/get_sensors_cubit.dart';
import 'package:hidroponik_app2/data/sensor_param.dart';
import 'package:hidroponik_app2/sensor_card.dart';
import 'package:intl/intl.dart';

// HomeTab Widget dengan AppBar khusus untuk "Good Morning"
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateFormat format = DateFormat('EEEE, dd MMMM yyyy');
  bool isHide = true;
  String? tanggalTanam;
  int umurTanaman = 0;
  //get Umur Tanaman
  void getTanggalTanam() async {
    final snapshot =
        await FirebaseDatabase.instance
            .ref('plant/settings/tanggalTanam')
            .get();

    if (snapshot.exists) {
      tanggalTanam = snapshot.value.toString();
      log('Tanggal dari Firebase: $tanggalTanam');
      try {
        final tanggal = DateTime.parse(tanggalTanam!);
        hitungUmurTanaman(tanggal);
      } catch (e) {
        log('Error parsing tanggal: $e');
      }
    }
  }

  @override
  void initState() {
    getTanggalTanam();
    setState(() {});
    super.initState();
  }

  void hitungUmurTanaman(DateTime tanamDate) {
    final now = DateTime.now();
    final difference = now.difference(tanamDate).inDays;
    log('Umur tanaman = $difference hari');
    setState(() {
      umurTanaman = difference;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSensorsCubit()..fetchData(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NutriPlant',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 24.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Welcome Back, Reni',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18.h,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Image.asset('assets/plant_ico.png', scale: 2),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),
                  InfoBanner(),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pump Control',
                        style: TextStyle(
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              isHide ? 'Hide' : 'Show',
                              style: TextStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Visibility(
                    visible: isHide,
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        ControlBanner(),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                  Visibility(visible: !isHide, child: Divider()),
                  Text(
                    'Sensor Information',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  BlocBuilder<GetSensorsCubit, GetSensorsState>(
                    builder: (context, state) {
                      if (state is GetSensorsLoaded) {
                        final sensorData = [
                          state.sensorsModel.ph,
                          state.sensorsModel.tds,
                          state.sensorsModel.wtemp,
                          state.sensorsModel.rtemp,
                          state.sensorsModel.hum,
                        ];
                        return GridView.builder(
                          padding: EdgeInsets.only(bottom: 16.h),
                          itemCount: sensorData.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 110.h,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                              ),
                          itemBuilder: (context, index) {
                            return SensorCard(
                              title: '${sensorParam[index]['name']}',
                              value: sensorData[index].toString(),
                              icon: Icons.water_drop,
                              symbol: sensorParam[index]['symbol'].toString(),
                              enableButton: false,
                            );
                          },
                        );
                      }
                      if (state is GetSensorsError) {
                        return Text('Error: ${state.error}');
                      }
                      return Text('ERROR NOT FOUND');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
