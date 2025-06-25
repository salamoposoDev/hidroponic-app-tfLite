import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/pengaturan/custom_list_tile.dart';
import 'package:hidroponik_app2/pengaturan/jadwal_nutrisi.dart';
import 'package:hidroponik_app2/pengaturan/mode_card.dart';
import 'package:hidroponik_app2/pengaturan/set_tanaman.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade50,
        toolbarHeight: 70.h,
        title: Text(
          'Pengaturan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.h,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModeCard(),
            SizedBox(height: 24.h),
            CustomListTile(
              name: 'Setting Tanaman',
              onTap: () {
                openButtonSheet(context);
              },
            ),
            SizedBox(height: 8.h),
            CustomListTile(
              name: 'Jadwal Nutrisi',
              onTap: () {
                openJadwalNutrisiSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void openButtonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TambahTanaman();
      },
    );
  }
}

void openJadwalNutrisiSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return JadwalNutrisi();
    },
  );
}
