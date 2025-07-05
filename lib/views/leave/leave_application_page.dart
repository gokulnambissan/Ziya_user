import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'package:ziya_user/views/profile/profile_page.dart';
import 'package:ziya_user/views/report/report_page.dart';
import 'leave_application_page_body.dart';

class LeaveApplicationPage extends StatelessWidget {
  const LeaveApplicationPage({super.key});

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
        else if(idx==1){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_)=> const ReportPage())
            );
        }
        else if(idx==3){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_)=> const ProfilePage())
            );
        }
      },
      body: const Column(
        children: [
          Expanded(child: LeaveApplicationPageBody()),
        ],
      ),
    );
  }
}