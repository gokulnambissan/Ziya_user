import 'package:flutter/material.dart';
import '../shared/dashboard_item.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        DashboardItem(icon: Icons.calendar_today, label: AppStrings.attendance, color: AppColors.green),
        DashboardItem(icon: Icons.exit_to_app, label:AppStrings.leave, color: AppColors.orange),
        DashboardItem(icon: Icons.pie_chart, label: AppStrings.orangetatus, color: AppColors.dashboardPurple),
        DashboardItem(icon: Icons.check_box, label: AppStrings.holidayList, color: AppColors.blue),
        DashboardItem(icon: Icons.money, label: AppStrings.payslip, color: AppColors.dashboardTeal),
        DashboardItem(icon: Icons.show_chart, label: AppStrings.reports, color: AppColors.red),
      ],
    );
  }
}
