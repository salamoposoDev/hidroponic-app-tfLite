import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/cubit/get_pump_history_cubit.dart';
import 'package:hidroponik_app2/cubit/get_sensor_history_cubit.dart';
import 'package:hidroponik_app2/format/format_time.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseDatabase.instance.ref('history/sensors');
    // ref.onValue.listen((event) {
    //   final value = event.snapshot.value;
    //   log(value.toString());
    // });
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70.h,
        title: Text(
          'Aktivitas',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black, size: 30.h),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedIndex == 0
                                ? Colors.blue
                                : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Text(
                        'Aktivitas Pompa',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedIndex == 1
                                ? Colors.blue
                                : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Text(
                        'Aktivitas Sensor',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (selectedIndex == 0)
              TabAktivitasPompa(scrennHeight: screenHeight),
            if (selectedIndex == 1)
              TapAktivitasSensor(scrennHeight: screenHeight),
          ],
        ),
      ),
    );
  }
}

class TapAktivitasSensor extends StatelessWidget {
  final double scrennHeight;
  const TapAktivitasSensor({super.key, required this.scrennHeight});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSensorHistoryCubit()..getData(),
      child: BlocBuilder<GetSensorHistoryCubit, GetSensorHistoryState>(
        builder: (context, state) {
          if (state is GetSensorHistoryLoaded) {
            final latestData =
                state.dataHistory.length > 50
                    ? state.dataHistory.take(50).toList()
                    : state.dataHistory.toList();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Data: ${state.dataHistory.length}',
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Expanded(child: Divider(indent: 4, endIndent: 4)),
                      Text(
                        'Lates Data: ${latestData.length}',
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ListView.builder(
                    itemCount:
                        latestData.length, // Ubah jumlah item sesuai kebutuhan
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final items = latestData[index];
                      final nomorUrut =
                          latestData.length - index; // Mulai dari 1, bukan 0

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Data $nomorUrut',
                                    style: TextStyle(
                                      fontSize: 16.h,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text(
                                        'ph: ${items.ph}, ppm: ${items.tds}, suhu: ${items.rtemp}',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                formatTimestamp(items.timestamp),
                                style: TextStyle(
                                  fontSize: 14.h,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: scrennHeight / 3),
              Text('Loading Data'),
              SizedBox(height: 8),
              CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}

class TabAktivitasPompa extends StatelessWidget {
  final double scrennHeight;
  const TabAktivitasPompa({super.key, required this.scrennHeight});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPumpHistoryCubit()..getData(),
      child: BlocBuilder<GetPumpHistoryCubit, GetPumpHistoryState>(
        builder: (context, state) {
          if (state is GetPumpHistoryLoded) {
            final latestData =
                state.pumpHistory.length > 50
                    ? state.pumpHistory.take(50).toList()
                    : state.pumpHistory.toList();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Data: ${state.pumpHistory.length}',
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Expanded(child: Divider(indent: 4, endIndent: 4)),
                      Text(
                        'Lates Data: ${latestData.length}',
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount:
                        latestData.length, // Ubah jumlah item sesuai kebutuhan
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final items = state.pumpHistory[index];
                      final nomorUrut =
                          latestData.length - index; // Mulai dari 1, bukan 0

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$nomorUrut. ${items.mode}',
                                    style: TextStyle(
                                      fontSize: 16.h,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    formatTimestamp(items.timestamp),
                                    style: TextStyle(
                                      fontSize: 14.h,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Ph Up: ${items.phUp}, Ph Down: ${items.phDown}, TDS: ${items.tds}, Air: ${items.air}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          if (state is GetPumpHistoryError) {
            return Text('error ${state.error}');
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: scrennHeight / 3),
              Text('Loading Data'),
              SizedBox(height: 8),
              CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}
