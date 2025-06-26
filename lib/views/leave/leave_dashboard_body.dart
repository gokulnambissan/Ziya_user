import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/leave_dashboard_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:ziya_user/views/leave/leave_application_page.dart';
import 'package:ziya_user/views/leave/leave_tab_header.dart';

class LeaveDashboardBody extends StatefulWidget {
  const LeaveDashboardBody({super.key});

  @override
  State<LeaveDashboardBody> createState() => _LeaveDashboardBodyState();
}

class _LeaveDashboardBodyState extends State<LeaveDashboardBody> {
  final LeaveDashboardViewModel viewModel = LeaveDashboardViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const TopNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            LeaveTabHeader(
              selectedTab: 0,
              onTabSelected: (index) {
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LeaveApplicationPage(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGrid(),
                    const SizedBox(height: 20),
                    DynamicHeightCard(child: _buildLeaveOverview()),
                    const SizedBox(height: 20),
                    DynamicHeightCard(child: _buildUpcomingLeave()),
                    const SizedBox(height: 12),
                    _buildPendingApprovalCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Total Leave Taken",
                  value: "${viewModel.totalLeaveTaken} days",
                  subtitle: "${viewModel.remainingLeave} days remaining this year",
                  icon: Icons.add_chart_outlined,
                  showProgress: true,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Approval Rate",
                  value: "${viewModel.approvalRate}%",
                  subtitle: "${viewModel.remainingLeave} days remaining this year",
                  icon: Icons.disc_full_outlined,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Pending Request",
                  value: "${viewModel.pendingRequests}",
                  subtitle: "${viewModel.remainingLeave} days remaining this year",
                  icon: Icons.hourglass_empty,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Team Member on Leave",
                  value: "${viewModel.teamMembersOnLeave}",
                  subtitle: "${viewModel.remainingLeave} days remaining this year",
                  icon: Icons.group_outlined,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeaveOverview() {
    final quarters = ["Q1", "Q2", "Q3", "Q4"];
    final data = viewModel.leavePerQuarter;
    final max = data.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Leave Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text("Your leave distribution for the current year"),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: max.toDouble() + 2,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final index = value.toInt();
                      if (index >= 0 && index < quarters.length) {
                        return Text(quarters[index], style: const TextStyle(fontSize: 12));
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(data.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: data[index].toDouble(),
                      width: 60,
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.blue,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: Column(
            children: const [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 4, backgroundColor: AppColors.blue),
                  SizedBox(width: 6),
                  Text("Leave days taken"),
                ],
              ),
              SizedBox(height: 6),
              Divider(thickness: 1, color: AppColors.grey),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total days: ${viewModel.leavePerQuarter.reduce((a, b) => a + b)}"),
            Text("Remaining: ${viewModel.remainingLeave}"),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingLeave() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Upcoming Leave", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text("Your scheduled time off"),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(viewModel.upcomingLeaveTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      viewModel.formattedLeaveDates,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: const Text("Pending"),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPendingApprovalCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 235, 204),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Icon(Icons.error_outline, color: AppColors.orange),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Your leave request is awaiting manager approval.",
              style: TextStyle(color: Colors.orangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}
