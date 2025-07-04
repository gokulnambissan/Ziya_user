import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/leave_dashboard_view_model.dart';
import 'package:ziya_user/views/common/inline_search_widget.dart';
import 'package:ziya_user/views/leave/leave_application_page.dart';
import 'package:ziya_user/views/leave/leave_tab_header_page.dart';

class LeaveDashboardBody extends StatefulWidget {
  const LeaveDashboardBody({super.key});

  @override
  State<LeaveDashboardBody> createState() => _LeaveDashboardBodyState();
}

class _LeaveDashboardBodyState extends State<LeaveDashboardBody> {
  final viewModel = LeaveDashboardViewModel();

  void _handleSearch(String query) {
    debugPrint('Leave Dashboard search triggered: $query');
    // TODO: Implement your actual search logic here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: kToolbarHeight,
              child: Column(
                children: [
                  LeaveTabHeaderPage(
                    selectedTab: 0,
                    onTabSelected: (index) {
                      if (index == 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LeaveApplicationPage()),
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
                          _buildStatGrid(),
                          const SizedBox(height: 20),
                          DynamicHeightCard(child: _buildLeaveOverview()),
                          const SizedBox(height: 20),
                          _buildUpcomingLeavesTable(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: InlineSearchWidget(
                searchHint: 'Search leave...',
                onSubmitQuery: _handleSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Total Leave Taken",
                  value: "${viewModel.totalLeaveTaken} days",
                  subtitle: "${viewModel.remainingLeave} days remaining",
                  icon: Icons.article_outlined,
                  showProgress: true,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Pending Request",
                  value: "${viewModel.pendingRequests}",
                  subtitle: "${viewModel.remainingLeave} days remaining",
                  icon: Icons.hourglass_empty,
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
                  title: "Leave Balance",
                  value: "${viewModel.leaveBalance} days",
                  subtitle: "${viewModel.remainingLeave} days remaining",
                  icon: Icons.date_range_outlined,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Approved Leaves",
                  value: "${viewModel.approvedLeaves} days",
                  subtitle: "${viewModel.remainingLeave} days remaining",
                  icon: Icons.check_circle_outline,
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
                  title: "Rejected Leaves",
                  value: "${viewModel.rejectedLeaves} days",
                  subtitle: "${viewModel.remainingLeave} days remaining",
                  icon: Icons.cancel_outlined,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Upcoming Leaves",
                  value: "${viewModel.upcomingLeaves} days",
                  extraText: "Scheduled (25 June)",
                  subtitle: "${viewModel.remainingLeave} days remaining",
                  icon: Icons.date_range_outlined,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeaveOverview() {
    final data = viewModel.leavePerQuarter;
    final max = data.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Leave Overview",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text("Your leave distribution for the current year",style: TextStyle(fontSize: 12),),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
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
                      const quarters = ["Q1", "Q2", "Q3", "Q4"];
                      final index = value.toInt();
                      return index >= 0 && index < quarters.length
                          ? Text(quarters[index])
                          : const Text('',style: TextStyle(fontSize: 12));
                    },
                  ),
                ),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(data.length, (i) {
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: data[i].toDouble(),
                      width: 50,
                      borderRadius: BorderRadius.circular(2),
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
                  CircleAvatar(radius: 3, backgroundColor: AppColors.blue),
                  SizedBox(width: 6),
                  Text("Leave days taken",style: TextStyle(fontSize: 12)),
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
            Text("Total days: ${data.reduce((a, b) => a + b)}",style: TextStyle(fontSize: 12)),
            Text("Remaining: ${viewModel.remainingLeave}",style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingLeavesTable() {
    Widget cell(String text, {TextStyle? style}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Text(
          text,
          style: style ?? const TextStyle(fontSize: 12, color: AppColors.black),
        ),
      );
    }

    final header = TableRow(children: [
      cell('Date', style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
      cell('Leave Type', style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
      cell('Status', style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
      cell('Reason', style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
    ]);

    final rows = viewModel.leaveRecords.map<TableRow>((record) {
      final statusColor = switch (record['status']) {
        'Approved' => AppColors.green,
        'Pending' => AppColors.pendingColor,
        'Rejected' => AppColors.red,
        _ => AppColors.black,
      };
      return TableRow(children: [
        cell(record['date']!),
        cell(record['type']!),
        cell(record['status']!, style: TextStyle(color: statusColor,fontSize: 12)),
        cell(record['reason']!),
      ]);
    }).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Table(
        border: TableBorder.all(color: AppColors.borderColor),
        columnWidths: const {
          0: FlexColumnWidth(1.6),
          1: FlexColumnWidth(1.6),
          2: FlexColumnWidth(1.6),
          3: FlexColumnWidth(1.6),
        },
        children: [header, ...rows],
      ),
    );
  }
}
