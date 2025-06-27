import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/leave_dashboard_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:ziya_user/views/leave/leave_application_page.dart';
import 'package:ziya_user/views/leave/leave_tab_header_page.dart';



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
      appBar: const TopNavigationBar(),          // ◀︎ Leaves  bar
      body: SafeArea(
        child: Column(
          children: [
            LeaveTabHeaderPage(
              selectedTab: 0,
              onTabSelected: (idx) {
                if (idx == 1) {
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
                    _buildGrid(),
                    const SizedBox(height: 20),
                    DynamicHeightCard(child: _buildLeaveOverview()),
                    const SizedBox(height: 20),
                    _buildUpcomingLeave(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────  UI building helpers  ──────────────────

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
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
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
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
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
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
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
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
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
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year ",
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
                  extraText: "Scheduled ( 25 June )",
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
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
    final quarters = ["Q1", "Q2", "Q3", "Q4"];
    final data = viewModel.leavePerQuarter;
    final max = data.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Leave Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        return Text(quarters[index],
                            style: const TextStyle(fontSize: 12));
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
            Text(
                "Total days: ${viewModel.leavePerQuarter.reduce((a, b) => a + b)}"),
            Text("Remaining: ${viewModel.remainingLeave}"),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingLeave() {
    Widget _cell(String text,
        {TextStyle? style,
        EdgeInsets padding =
            const EdgeInsets.symmetric(vertical: 14, horizontal: 8)}) {
      return Padding(
        padding: padding,
        child: Text(
          text,
          style: style ??
              const TextStyle(
                fontSize: 14,
                color: AppColors.black,
              ),
        ),
      );
    }

    final headerRow = TableRow(children: [
      _cell('Date',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600)),
      _cell('Leave Type',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600)),
      _cell('Status',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600)),
      _cell('Reason',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600)),
    ]);

    final dataRows = viewModel.leaveRecords.map<TableRow>((record) {
      final statusStyle = TextStyle(
        color: switch (record['status']) {
          'Approved' => AppColors.green,
          'Pending' => AppColors.pendingColor,
          'Rejected' => AppColors.red,
          _ => AppColors.black,
        },
      );

      return TableRow(children: [
        _cell(record['date']!),
        _cell(record['type']!),
        _cell(record['status']!, style: statusStyle),
        _cell(record['reason']!),
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
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(1.6),
          1: FlexColumnWidth(1.6),
          2: FlexColumnWidth(1.6),
          3: FlexColumnWidth(1.6),
        },
        children: [headerRow, ...dataRows],
      ),
    );
  }
}
