
import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/views/home/home_screen.dart';
import 'leave_application_page_body.dart';

class LeaveApplicationPage extends StatelessWidget {
  const LeaveApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 2, 
      onTap: (index) {
        if (index == 2) return; 

        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
            break;
          // Add more case if needed for other tabs
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
