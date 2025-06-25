import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidroponik_app2/aktivitas/aktivitas.dart';
import 'package:hidroponik_app2/beranda/beranda.dart';
import 'package:hidroponik_app2/firebase_options.dart';
import 'package:hidroponik_app2/pengaturan/pengaturan.dart';
import 'package:hidroponik_app2/tanaman/tanaman.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Firebase berhasil diinisialisasi');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 806),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        title: 'Nutriplant',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // DatabaseReference ref = FirebaseDatabase.instance.ref('sensors');
    // try {
    //   log('coba get data');
    //   ref.onValue.listen((event) {
    //     log('mencoba listener');
    //     if (event.snapshot.exists) {
    //       log(event.snapshot.value.toString());
    //     } else {
    //       print('no data');
    //     }
    //   });
    // } catch (e) {
    //   log(e.toString());
    // }
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeTab(), // Halaman Beranda dengan "Good Morning" di AppBar
          ActivityTab(), // Halaman Aktivitas
          PlantTab(), // Halaman Tanaman
          SettingsTab(), // Halaman Pengaturan
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: _selectedIndex == 0 ? Colors.green : Colors.grey,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              color: _selectedIndex == 1 ? Colors.green : Colors.grey,
            ),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.eco,
              color: _selectedIndex == 2 ? Colors.green : Colors.grey,
            ),
            label: 'Tanaman',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _selectedIndex == 3 ? Colors.green : Colors.grey,
            ),
            label: 'Pengaturan',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
