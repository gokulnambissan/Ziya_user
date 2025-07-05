import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'package:ziya_user/views/leave/leave_dashboard_page.dart';
import 'package:ziya_user/views/profile/profile_page_body.dart';
import 'package:ziya_user/views/report/report_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 3,
      onTap: (index) {
        if (index == 3) return;
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
        if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LeaveDashboardPage()),
          );
        }
      },
      body: const Column(
        children: [
          Expanded(child: ProfilePageBody()),
        ],
      ),
    );
  }
}
