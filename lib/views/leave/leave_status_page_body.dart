// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/leave_calender_constants.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/leave_dashboard_view_model.dart';
import 'package:ziya_user/views/common/search_overlay.dart'
    show showSearchOverlay;
import 'package:ziya_user/views/common/top_navigation_bar.dart';

class LeaveStatusPageBody extends StatefulWidget {
  const LeaveStatusPageBody({super.key});

  @override
  State<LeaveStatusPageBody> createState() => _LeaveStatusPageBodyState();
}

class _LeaveStatusPageBodyState extends State<LeaveStatusPageBody> {
  final LeaveDashboardViewModel viewModel = LeaveDashboardViewModel();

  final GlobalKey _searchKey = GlobalKey();
  String _searchHint = 'Search';


  void _handleSearchTap() {
    setState(() => _searchHint = '05 May 2025');
    showSearchOverlay(
      context,
      searchBarKey: _searchKey,
      afterClosed: () => setState(() => _searchHint = 'Search'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: TopNavigationBar(
        onSearchTap: _handleSearchTap,
        searchBarKey: _searchKey,
        searchHint: _searchHint,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGrid(),
                    const SizedBox(height: 20),
                    _buildCalendar(),
                    const SizedBox(height: 20),
                    _buildUpcomingLeave(),
                    const SizedBox(height: 20),
                    DynamicHeightCard(child: _buildLeaveOverview()),
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
                  title: "Leave Taken",
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
                  title: "Leave Balance",
                  value: "${viewModel.leaveBalance} days",
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
                  icon: Icons.date_range_outlined,
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
                  value: "${viewModel.pendingRequests} request",
                  subtitle:
                      "${viewModel.remainingLeave} days remaining this year",
                  icon: Icons.hourglass_empty,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: StatCard(
                  title: "Approved Leaves",
                  value: "${viewModel.approvedLeaves} leaves",
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
                  value: "${viewModel.rejectedLeaves} leaves",
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

Widget _buildCalendar() {
  final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final daysInJune = List<int>.generate(30, (index) => index + 1);

  
  final firstDay = DateTime(2025, 6, 1);
  final weekdayOfFirst = firstDay.weekday; 
  final blanks = weekdayOfFirst % 7;

  final items = [
    ...List.generate(blanks, (_) => null),
    ...daysInJune,
  ];

  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDays
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: day == 'Sun' ? Colors.red : AppColors.black,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 14),
        const Text(
          "June 2025",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final day = items[index];
            if (day == null) {
              return const SizedBox(); // empty cell for alignment
            }

            final date = DateTime(2025, 6, day);
            final status = viewModel.statusForDate(date);

            Color? bgColor;
            switch (status) {
              case LeaveStatus.approved:
                bgColor = const Color.fromARGB(255, 29, 211, 35);
                break;
              case LeaveStatus.pending:
                bgColor = const Color.fromARGB(255, 250, 215, 38);
                break;
              case LeaveStatus.rejected:
                bgColor = const Color.fromARGB(255, 247, 38, 23);
                break;
              case LeaveStatus.upcoming:
                bgColor = const Color.fromARGB(255, 20, 148, 252);
                break;
              default:
                bgColor = AppColors.white;
            }

            final isSunday = index % 7 == 0;

            return Container(
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 16,
                  color: bgColor == AppColors.white
                      ? (isSunday ? Colors.red : AppColors.black)
                      : AppColors.white,
                ),
              ),
            );
          },
        ),
      ],
    ),
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
                "Total days: \n${viewModel.leavePerQuarter.reduce((a, b) => a + b)}"),
            Text("Remaining: \n${viewModel.remainingLeave}"),
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
