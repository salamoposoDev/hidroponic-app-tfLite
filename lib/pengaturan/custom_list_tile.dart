import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.name, this.onTap});
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        name,
        style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
      ),
      tileColor: Colors.white,
      splashColor: Colors.green,
      trailing: Icon(Icons.keyboard_arrow_right),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    );
  }
}
