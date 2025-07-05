import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'package:ziya_user/views/leave/leave_dashboard_page.dart';
import 'package:ziya_user/views/profile/profile_page.dart';
import 'package:ziya_user/views/report/report_page_body.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 1,
      onTap: (index) {
        if (index == 1) return;
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
        else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LeaveDashboardPage()),
          );
        }
        else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        }
      },
      body: const Column(
        children: [
          Expanded(child: ReportPageBody()),
        ],
      ),
    );
  }
}
