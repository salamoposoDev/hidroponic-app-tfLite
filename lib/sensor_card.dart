import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String symbol;
  final bool? enableButton;

  const SensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.symbol,
    this.enableButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44.h,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Color(0xFFF0EFEF),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(-2, 2), blurRadius: 3),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(icon, size: 24.h, color: Colors.green),
            ],
          ),
          SizedBox(height: 18.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (child, animation) => FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        ),
                    child: Text(
                      key: ValueKey<String>(value),
                      value,
                      style: TextStyle(
                        fontSize: 24.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),

                  Text(
                    ' $symbol',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: enableButton!,
                child: InkWell(
                  onTap: () {},
                  child: Icon(Icons.power_settings_new),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
