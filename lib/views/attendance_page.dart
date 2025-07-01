import 'package:flutter/material.dart';
import 'package:ziya_user/views/attendance_page_body.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 2,
      onTap: (idx) {
        if (idx == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      },
      body: const Column(
        children: [
          Expanded(child: AttendancePageBody()),
        ],
      ),
    );
  }
}