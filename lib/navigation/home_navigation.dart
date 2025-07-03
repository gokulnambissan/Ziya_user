import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/bottom_navigation_viewmodel.dart';
import 'package:ziya_user/views/leave/leave_application_page.dart';

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
        // Home tab
        break;
      case 2:
        // Leave Application tab
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LeaveApplicationPage()),
        );
        break;
      // Add cases for History (1) and Profile (3) if needed
    }

    viewModel.setIndex(index, updateUI);
  }
}
