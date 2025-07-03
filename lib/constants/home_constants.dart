import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'package:ziya_user/views/tasks_page.dart';
import 'package:ziya_user/views/tracker_page.dart';
import 'package:ziya_user/views/ongoing_pending_page.dart';
import 'package:ziya_user/views/work_summary_page.dart';

class HomeConstants {
  static final List<Widget> pages = [
    TasksPage(),
    TrackerPage(),
    OngoingPendingPage(),
    WorkSummaryPage(),
  ];

  static const List<String> pageTitles = [
    AppStrings.myTasks,
    AppStrings.taskTracker,
    AppStrings.ongoingPending,
    AppStrings.workSummary,
  ];

  static const List<IconData> pageIcons = [
    Icons.calendar_today,
    Icons.hourglass_empty_sharp,
    Icons.sync_sharp,
    Icons.event_note_sharp,
  ];
}
