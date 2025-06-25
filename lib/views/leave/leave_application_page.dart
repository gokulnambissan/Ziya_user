
import 'package:flutter/material.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';


import 'leave_application_page_body.dart';

class LeaveApplicationPage extends StatelessWidget {
  const LeaveApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationLayout(
      currentIndex: 2, // index for "Leave"
      onTap: (index) {
       
      },
      body: Column(
        children: const [
          Expanded(child: LeaveApplicationPageBody()),
        ],
      ),
    );
  }
}
