import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziya_user/home/checkin_section.dart';
import 'package:ziya_user/home/header_section.dart';
import 'package:ziya_user/home/navigation_tabs.dart';
import '../pages/tasks_page.dart';
import '../pages/tracker_page.dart';
import '../pages/ongoing_pending_page.dart';
import '../pages/work_summery_page.dart';
import '../shared/overview_section.dart';
import '../shared/filter_options.dart';
import '../home/dashboard_grid.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int currentPage = 0;
  bool checkedIn = false;
  bool isDeadlineSelected = true;

  String checkInStatus = AppStrings.checkInPrompt;
  Color statusColor = AppColors.red;

  String? userName;
  String? checkOutTimeMessage;
  final currentUser = FirebaseAuth.instance.currentUser;

  final List<Widget> pages = [
    TasksPage(),
    TrackerPage(),
    OngoingPendingPage(),
    WorkSummaryPage(),
  ];

  final List<String> pageTitles = [
    AppStrings.myTasks,
    AppStrings.taskTracker,
    AppStrings.ongoingPending,
    AppStrings.workSummary,
  ];

  final List<IconData> pageIcons = [
    Icons.calendar_today,
    Icons.access_time,
    Icons.pending_actions,
    Icons.summarize,
  ];

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      if (currentUser != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        setState(() {
          userName = doc.data()?['name'] ?? currentUser!.email;
        });
      }
    } catch (e) {
      setState(() {
        userName = currentUser?.email;
      });
    }
  }

  String getFormattedTime() {
    return DateFormat.jm().format(DateTime.now());
  }

  void handleCheckIn() {
    setState(() {
      checkInStatus = "You've Checked-in at ${getFormattedTime()}";
      statusColor = AppColors.green;
      checkedIn = true;
      checkOutTimeMessage = null;
    });
  }

  void handleCheckOut() {
    setState(() {
      checkInStatus = AppStrings.checkInPrompt;
      statusColor = AppColors.red;
      checkedIn = false;
      checkOutTimeMessage = "You've Checked-out at ${getFormattedTime()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          setState(() => selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.home),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: AppStrings.history),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: AppStrings.leave),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: AppStrings.profile),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(userName: userName ?? "..."),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.goodMorning,
                  style: TextStyle(fontSize: 18, color: AppColors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  '${userName ?? ''}"',
                  style: const TextStyle(fontSize: 18, color: AppColors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CheckInSection(
              checkedIn: checkedIn,
              statusColor: statusColor,
              checkInStatus: checkInStatus,
              onCheckIn: handleCheckIn,
              onCheckOut: handleCheckOut,
              checkOutTimeMessage: checkOutTimeMessage,
            ),
            const SizedBox(height: 24),
            const Text(AppStrings.overview,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const OverviewSection(),
            const SizedBox(height: 24),
            NavigationTabs(
              currentPage: currentPage,
              pageIcons: pageIcons,
              pageTitles: pageTitles,
              onTabSelected: (index) {
                setState(() => currentPage = index);
              },
            ),
            const SizedBox(height: 24),
            FilterOptions(
              isDeadlineSelected: isDeadlineSelected,
              onChanged: (value) {
                setState(() => isDeadlineSelected = value);
              },
            ),
            const SizedBox(height: 12),
            pages[currentPage],
            const SizedBox(height: 16),
            const Text(AppStrings.dashboard,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const DashboardGrid(),
          ],
        ),
      ),
    );
  }
}
