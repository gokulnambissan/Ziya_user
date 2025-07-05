import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'package:ziya_user/views/profile/profile_page.dart';
import 'leave_dashboard_body.dart';
import 'package:ziya_user/views/report/report_page.dart';

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
        else if(index==1){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_)=> const ReportPage())
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
          Expanded(child: LeaveDashboardBody()),
        ],
      ),
    );
  }
}
