import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/cubit/get_mode_cubit.dart';

class ModeCard extends StatelessWidget {
  const ModeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetModeCubit()..getMode(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 2),
          ],
        ),
        child: BlocBuilder<GetModeCubit, int>(
          builder: (context, state) {
            int value = state;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mode Nutrisi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.h,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (value == 1) {
                      value = 0;
                    } else {
                      value = 1;
                    }
                    context.read<GetModeCubit>().setMode(value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    value == 1 ? 'Otomatis' : 'Manual',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.h,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
