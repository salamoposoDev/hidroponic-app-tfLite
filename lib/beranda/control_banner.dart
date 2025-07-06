import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/cubit/get_control_cubit.dart';
import 'package:hidroponik_app2/cubit/get_mode_cubit.dart';

class ControlBanner extends StatelessWidget {
  const ControlBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseDatabase.instance.ref('/pump');
    // ref.onValue.listen((event) {
    //   log(event.snapshot.value.toString());
    // });
    const items = ['Pump PH uP', 'Pump PH Down', 'Pump Nutrisi', 'Pump Air'];

    // final mode = context.read<GetModeCubit>().state;
    // log('mode= $mode');

    return BlocProvider(
      create: (context) => GetControlCubit()..getPumpStatus(),
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(-4, 4), blurRadius: 5),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<GetControlCubit, GetControlState>(
              builder: (context, state) {
                if (state is GetControlData) {
                  final controlData = [
                    state.controlModel.phUp,
                    state.controlModel.phDown,
                    state.controlModel.nutrisi,
                    state.controlModel.air,
                  ];

                  log(controlData.toString());
                  return GridView.builder(
                    itemCount: controlData.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 45.h,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemBuilder: (context, index) {
                      final isAnyActive = controlData.any(
                        (value) => value != 0,
                      );

                      return Container(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(-2, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              items[index],
                              style: TextStyle(
                                fontSize: 13.h,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            BlocBuilder<GetModeCubit, int>(
                              builder: (context, mode) {
                                return mode == 0
                                    ? IconButton(
                                      onPressed:
                                          !isAnyActive
                                              ? () {
                                                const key = [
                                                  'phUp',
                                                  'phDown',
                                                  'nutrisi',
                                                  'air',
                                                ];
                                                context
                                                    .read<GetControlCubit>()
                                                    .updateSingleField(
                                                      key[index],
                                                      1,
                                                    );
                                              }
                                              : null,
                                      icon:
                                          controlData[index] == 0
                                              ? Icon(
                                                Icons.power_settings_new,
                                                size: 22,
                                              )
                                              : SizedBox(
                                                height: 18.h,
                                                width: 18.w,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                    )
                                    : Text('Auto');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Text('Something Wrong');
              },
            ),
          ],
        ),
      ),
    );
  }
}
