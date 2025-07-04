import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziya_user/view_models/filter_options_viewmodel.dart';
import 'package:ziya_user/view_models/bottom_navigation_viewmodel.dart';
import 'package:ziya_user/view_models/punch_viewmodel.dart';
import 'package:ziya_user/views/overview_section.dart';
import 'package:ziya_user/views/work_from_home/center_face_page.dart';
import 'package:ziya_user/views/work_from_home/face_verification_page.dart';
import 'package:ziya_user/views/filter_options.dart';
import 'package:ziya_user/views/home/dashboard_grid.dart';
import 'package:ziya_user/views/home/punch_dialogs.dart';
import 'package:ziya_user/views/common/punch_out_success.dart';
import 'package:ziya_user/views/on_site/qr_verification_page.dart';
import 'package:ziya_user/views/on_site/scan_qr_code_page.dart';
import 'package:ziya_user/views/home/checkin_section.dart';
import 'package:ziya_user/views/home/header_section.dart';
import 'package:ziya_user/views/home/navigation_tabs.dart';
import 'package:ziya_user/views/common/bottom_navigation.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/home_constants.dart';
import 'package:ziya_user/navigation/home_navigation.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QrVerificationPage()),
          ).then((result) {
            if (result == true) punchVM.punchIn(updateUI, "On Site");
          });
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
                      punchVM.punchOut(updateUI);
                    });
                  }
                });
              }
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QrVerificationPage(isPunchOutFlow: true),
              ),
            ).then((qrVerified) {
              if (qrVerified == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScanQrPage(isPunchOutFlow: true),
                  ),
                ).then((qrCentered) {
                  if (qrCentered == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PunchOutSuccessPage(),
                      ),
                    ).then((_) {
                      punchVM.punchOut(updateUI);
                    });
                  }
                });
              }
            });
          }
        }
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
    return BottomNavigationLayout(
      currentIndex: bottomNavViewModel.currentIndex,
      onTap: (index) {
        HomeNavigation.handleBottomNavTap(
          context: context,
          index: index,
          viewModel: bottomNavViewModel,
          updateUI: updateUI,
        );
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(userName: userName ?? "..."),
            const SizedBox(height: 14),
            const Text(
              AppStrings.goodMorning,
              style: TextStyle(fontSize: 14, color: AppColors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              '${userName ?? ''}',
              style: const TextStyle(fontSize: 14, color: AppColors.grey),
            ),
            const SizedBox(height: 12),
            CheckInSection(
              checkInStatus: punchVM.checkInStatus,
              statusColor: punchVM.statusColor,
              checkedIn: punchVM.checkedIn,
              checkOutTimeMessage: punchVM.checkOutTimeMessage,
              extraTimeInfo: punchVM.extraTimeInfo,
              locationInfo: punchVM.locationInfo,
              onPunchInTap: handlePunchInFlow,
              onPunchOutTap: handlePunchOutFlow,
            ),
            const SizedBox(height: 20),
            const Text(
              AppStrings.overview,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const OverviewSection(),
            const SizedBox(height: 24),
            NavigationTabs(
              currentPage: currentPage,
              pageIcons: HomeConstants.pageIcons,
              pageTitles: HomeConstants.pageTitles,
              onTabSelected: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 8),
            HomeConstants.pages[currentPage],
            const SizedBox(height: 14),
            const Text(
              AppStrings.dashboard,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const DashboardGrid(),
          ],
        ),
      ),
    );
  }
}
