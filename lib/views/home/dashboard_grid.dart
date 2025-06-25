import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/dashboard_item_viewmodel.dart';
import 'package:ziya_user/views/dashboard_item.dart';
import 'package:ziya_user/views/leave/leave_application_page.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_colors.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      DashboardItemViewModel(
          icon: Icons.calendar_today,
          label: AppStrings.attendance,
          color: AppColors.green),
      DashboardItemViewModel(
          icon: Icons.exit_to_app,
          label: AppStrings.leave,
          color: AppColors.orange),
      DashboardItemViewModel(
          icon: Icons.pie_chart,
          label: AppStrings.orangetatus,
          color: AppColors.dashboardPurple),
      DashboardItemViewModel(
          icon: Icons.check_box,
          label: AppStrings.holidayList,
          color: AppColors.blue),
      DashboardItemViewModel(
          icon: Icons.money,
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
          MaterialPageRoute(builder: (context) => const LeaveApplicationPage()),
        );
      }
    },
    child: DashboardItem(viewModel: viewModel),
  );
}).toList(),
    );
  }
}
