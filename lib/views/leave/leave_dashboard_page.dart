import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'leave_dashboard_body.dart';

class LeaveDashboardPage extends StatelessWidget {
  const LeaveDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 2,
      onTap: (index) {
        if (index == 2) return;
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      },
      body: const Column(
        children: [
          Expanded(child: LeaveDashboardBody()),
        ],
      ),
    );
  }
}
