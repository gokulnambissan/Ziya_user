import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'package:ziya_user/views/leave/leave_dashboard_page.dart';
import 'package:ziya_user/views/payslip/payslip_body.dart';
import 'package:ziya_user/views/profile/profile_page.dart';
import 'package:ziya_user/views/report/report_page.dart';


class PayslipPage extends StatelessWidget {
  const PayslipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 0, 
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
        else if(idx==2){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_)=> const LeaveDashboardPage())
            );
        }
        else if (idx == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        }
      },
      body: Column(
        children: [
          Expanded(child: PayslipPageBody()),
        ],
      ),
    );
  }
}
