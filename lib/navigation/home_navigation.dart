import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/bottom_navigation_viewmodel.dart';
import 'package:ziya_user/views/profile/profile_page.dart';
import 'package:ziya_user/views/leave/leave_application_page.dart';
import 'package:ziya_user/views/report/report_page.dart';

class HomeNavigation {
  static void handleBottomNavTap({
    required BuildContext context,
    required int index,
    required BottomNavigationViewModel viewModel,
    required VoidCallback updateUI,
  }) {
    if (index == viewModel.currentIndex) return;

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ReportPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LeaveApplicationPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
    }

    viewModel.setIndex(index, updateUI);
  }
}
