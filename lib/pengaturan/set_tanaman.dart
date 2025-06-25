import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/common/widgets/alertDialog.dart';
import 'package:hidroponik_app2/cubit/setting_tanaman_cubit.dart';
import 'package:hidroponik_app2/model/setting_tanaman.dart';
import 'package:intl/intl.dart';

class TambahTanaman extends StatefulWidget {
  const TambahTanaman({super.key});

  @override
  State<TambahTanaman> createState() => _TambahTanamanState();
}

class _TambahTanamanState extends State<TambahTanaman> {
  DateFormat format = DateFormat('EEEE, dd MMMM yyyy');
  final jenisTanaman = ['Selada', 'Kangkung', 'Bayam', 'Pakcoy'];
  String selectedFase = '';
  String? selectedPlant;
  String? selectedUmur;
  String? selectedTanggal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingTanamanCubit()..loadTanaman(),
      child: BlocBuilder<SettingTanamanCubit, SettingTanamanState>(
        builder: (context, state) {
          if (state is TanamanError) {
            return Text('error: ${state.message}');
          }
          if (state is TanamanLoaded) {
            return Padding(
              padding: EdgeInsets.all(16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Setting Tanaman',
                        style: TextStyle(
                          fontSize: 18.h,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Dropdown untuk Jenis Tanaman
                  Text(
                    'Jenis tanaman',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    hint: Text(
                      'Pilih Tanaman...',
                      style: TextStyle(
                        fontSize: 16.h,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    value: selectedPlant,
                    items:
                        jenisTanaman.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                    onChanged: (value) {
                      selectedPlant = value;
                    },
                  ),
                  Text(
                    'Saat ini: ${state.data.plantStr}',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.w400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Tanggal Tanam',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedTanggal =
                                pickedDate
                                    .toString(); // atau gunakan format lain
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 16.h,
                          ),
                        ),
                        child: Text(
                          selectedTanggal != null
                              ? DateFormat(
                                'EEE, dd MMMM yyyy',
                              ).format(DateTime.parse(selectedTanggal!))
                              : 'Pilih Tanggal...',
                          style: TextStyle(fontSize: 16.h),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Saat ini: ${format.format(DateTime.parse(state.data.tanggalTanam))}',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.w400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      log('Update Data');
                      if (selectedPlant != null && selectedTanggal != null) {
                        final dayOne = DateTime.parse(
                          selectedTanggal.toString(),
                        );

                        context.read<SettingTanamanCubit>().setTanaman(
                          SettingTanamanModel(
                            plantStr: selectedPlant!,
                            day: hitungUmurTanaman(dayOne),
                            ageInWeek: umurTanamanWeek(
                              hitungUmurTanaman(dayOne),
                            ),
                            plantInt: jenisInt(selectedPlant!),
                            tanggalTanam: selectedTanggal!,
                          ),
                        );
                        showAppDialog(
                          context,
                          title: 'Berhasil',
                          content: "Data Sudah di Update",
                          onConfirm: () => Navigator.pop(context),
                        );
                      } else {
                        log('Ada yang kosong');
                        showAppDialog(
                          context,
                          title: 'Gagal',
                          content: "Ada Field Kosong...",
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.maxFinite.h, 50.h),
                      backgroundColor: Colors.green, // Warna hijau
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Simpan perubahan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 26.h),
                ],
              ),
            );
          }
          return Text('Error tidak tiketahui');
        },
      ),
    );
  }
}

int hitungUmurTanaman(DateTime tanamDate) {
  final now = DateTime.now();
  final difference = now.difference(tanamDate).inDays;
  // log('Umur tanaman = $difference hari');
  return difference;
}

int umurTanamanWeek(int umurDay) {
  if (umurDay >= 1 && umurDay <= 14) {
    return 1;
  } else if (umurDay >= 15 && umurDay <= 28) {
    return 2;
  } else {
    return 3;
  }
}

int jenisInt(String tanaman) {
  int tanamanInt = 0;
  switch (tanaman) {
    case 'Selada':
      return tanamanInt = 1;
    case 'Kangkung':
      return tanamanInt = 2;
    case 'Bayam':
      return tanamanInt = 3;
    case 'Pakcoy':
      return tanamanInt = 4;
  }
  return tanamanInt;
}
