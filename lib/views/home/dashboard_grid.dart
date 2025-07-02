import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/dashboard_item_viewmodel.dart';
import 'package:ziya_user/views/attendance/attendance_page.dart';
import 'package:ziya_user/views/dashboard_item.dart';
import 'package:ziya_user/views/holiday_page.dart';
import 'package:ziya_user/views/leave/leave_dashboard_page.dart';
import 'package:ziya_user/views/leave/leave_status_page.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_colors.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      DashboardItemViewModel(
          icon: Icons.calendar_month_sharp,
          label: AppStrings.attendance,
          color: AppColors.green),
      DashboardItemViewModel(
          icon: Icons.logout_sharp,
          label: AppStrings.leave,
          color: AppColors.orange),
      DashboardItemViewModel(
          icon: Icons.pie_chart_outline,
          label: AppStrings.leaveStatus,
          color: AppColors.dashboardPurple),
      DashboardItemViewModel(
          icon: Icons.checklist_sharp,
          label: AppStrings.holidayList,
          color: AppColors.blue),
      DashboardItemViewModel(
          icon: Icons.receipt_long_sharp,
          label: AppStrings.payslip,
          color: AppColors.dashboardTeal),
      DashboardItemViewModel(
          icon: Icons.show_chart,
          label: AppStrings.reports,
          color: AppColors.red),
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: items
          .map((viewModel) {
  return GestureDetector(
    onTap: () {
      if (viewModel.label == AppStrings.leave) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeaveDashboardPage()),
        );
      }
      else if (viewModel.label == AppStrings.holidayList) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HolidayPage()),
        );
      }
      else if (viewModel.label == AppStrings.attendance) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
      }
      else if (viewModel.label == AppStrings.leaveStatus) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeaveStatusPage()),
        );
      }
    },
    child: DashboardItem(viewModel: viewModel),
  );
}).toList(),
    );
  }
}
