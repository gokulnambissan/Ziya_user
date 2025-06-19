import 'package:flutter/material.dart';
import '../shared/dashboard_item.dart';

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
        DashboardItem(icon: Icons.calendar_today, label: 'Attendance', color: Colors.green),
        DashboardItem(icon: Icons.exit_to_app, label: 'Leaves', color: Colors.orange),
        DashboardItem(icon: Icons.pie_chart, label: 'Leave Status', color: Colors.purple),
        DashboardItem(icon: Icons.check_box, label: 'Holiday List', color: Colors.blue),
        DashboardItem(icon: Icons.money, label: 'Payslip', color: Colors.teal),
        DashboardItem(icon: Icons.show_chart, label: 'Reports', color: Colors.red),
      ],
    );
  }
}
