import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziya_user/view_models/filter_options_viewmodel.dart';
import 'package:ziya_user/view_models/bottom_navigation_viewmodel.dart';
import 'package:ziya_user/view_models/punch_viewmodel.dart';
import 'package:ziya_user/views/center_face_page.dart';
import 'package:ziya_user/views/face_verification_page.dart';
import 'package:ziya_user/views/filter_options.dart';
import 'package:ziya_user/views/home/dashboard_grid.dart';
import 'package:ziya_user/views/home/punch_dialogs.dart';
import 'package:ziya_user/views/ongoing_pending_page.dart';
import 'package:ziya_user/views/overview_section.dart';
import 'package:ziya_user/views/punch_out_success.dart';
import 'package:ziya_user/views/tasks_page.dart';
import 'package:ziya_user/views/tracker_page.dart';
import 'package:ziya_user/views/work_summary_page.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_colors.dart';
import 'checkin_section.dart';
import 'header_section.dart';
import 'navigation_tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  bool isDeadlineSelected = true;

  final PunchViewModel punchVM = PunchViewModel();
  final BottomNavigationViewModel bottomNavViewModel =
      BottomNavigationViewModel();

  String? userName;
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

  void updateUI() => setState(() {});

  void handlePunchInFlow() {
    PunchDialogs.showUnifiedPunchDialog(
      context: context,
      isPunchIn: true,
      onSelected: (type) {
        if (type == "Work From Home") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FaceVerificationPage()),
          ).then((result) {
            if (result == true) punchVM.punchIn(updateUI, "Work From Home");
          });
        } else {
          punchVM.punchIn(updateUI, "On Site");
        }
      },
    );
  }


void handlePunchOutFlow() {
  PunchDialogs.showUnifiedPunchDialog(
    context: context,
    isPunchIn: false,
    onSelected: (type) async {
      if (type == "Punch Out") {
        String? mode = await punchVM.getLastPunchInMode();

        if (mode == "Work From Home") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FaceVerificationPage(isPunchOutFlow: true),
            ),
          ).then((faceVerified) {
            if (faceVerified == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CenterFacePage(isPunchOutFlow: true),
                ),
              ).then((faceCentered) {
                if (faceCentered == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PunchOutSuccessPage(),
                    ),
                  ).then((_) {
                    punchVM.punchOut(updateUI); // mark state as punched out
                  });
                }
              });
            }
          });
        } else {
          // Replace with actual QR Verification when available
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('QR verification for On Site punch out not implemented yet.'),
            ),
          );
        }
      }
      // If "Update Task" is selected, do nothing or handle accordingly
    },
  );
}


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
        userName = currentUser?.email ?? 'Unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(userName: userName ?? "..."),
            const SizedBox(height: 16),
            const Text(
              AppStrings.goodMorning,
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              '${userName ?? ''}',
              style: const TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            const SizedBox(height: 12),
            CheckInSection(
              checkInStatus: punchVM.checkInStatus,
              statusColor: punchVM.statusColor,
              checkedIn: punchVM.checkedIn,
              checkOutTimeMessage: punchVM.checkOutTimeMessage,
              onPunchInTap: handlePunchInFlow,
              onPunchOutTap: handlePunchOutFlow,
            ),
            const SizedBox(height: 24),
            const Text(
              AppStrings.overview,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const OverviewSection(),
            const SizedBox(height: 24),
            NavigationTabs(
              currentPage: currentPage,
              pageIcons: pageIcons,
              pageTitles: pageTitles,
              onTabSelected: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
            const SizedBox(height: 24),
            FilterOptions(
              viewModel: FilterOptionsViewModel(
                isDeadlineSelected: isDeadlineSelected,
                onChanged: (value) {
                  setState(() {
                    isDeadlineSelected = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            pages[currentPage],
            const SizedBox(height: 16),
            const Text(
              AppStrings.dashboard,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const DashboardGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavViewModel.currentIndex,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          bottomNavViewModel.setIndex(index, () {
            setState(() {});
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: bottomNavViewModel.currentIndex == 0
                    ? AppColors.blue
                    : AppColors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,
                color: bottomNavViewModel.currentIndex == 1
                    ? AppColors.blue
                    : AppColors.grey),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,
                color: bottomNavViewModel.currentIndex == 2
                    ? AppColors.blue
                    : AppColors.grey),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: bottomNavViewModel.currentIndex == 3
                    ? AppColors.blue
                    : AppColors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
