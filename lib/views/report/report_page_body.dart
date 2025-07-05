// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/app_strings.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/report_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:ziya_user/views/common/inline_search_bar.dart';

class ReportPageBody extends StatefulWidget {
  const ReportPageBody({super.key});

  @override
  State<ReportPageBody> createState() => _ReportPageBodyState();
}

class _ReportPageBodyState extends State<ReportPageBody> {
  final ReportViewModel viewModel = ReportViewModel();

  bool isSearching = false;
  String searchQuery = '';
  final List<String> searchHistory = [];

  void _handleSearchSubmit() {
    final query = searchQuery.trim();
    if (query.isEmpty) return;

    setState(() {
      searchHistory.insert(0, query);
      searchQuery = '';
      isSearching = false;
    });

    debugPrint('Search submitted: $query');
  }

  void _toggleSearch(bool enable) {
    setState(() {
      isSearching = enable;
      if (!enable) searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Content ──
            Positioned.fill(
              top: kToolbarHeight,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.arrow_back_ios, size: 16, color: AppColors.black),
                          SizedBox(width: 4),
                          Text(
                            'Reports',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatGrid(),
                    const SizedBox(height: 20),
                    buildDailyLogTable(),
                    const SizedBox(height: 20),
                    buildReportChart(),
                  ],
                ),
              ),
            ),

            // ── Top Bar / Inline Search ──
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: isSearching
                  ? InlineSearchBar(
                      query: searchQuery,
                      onQueryChanged: (val) =>
                          setState(() => searchQuery = val),
                      onSubmit: _handleSearchSubmit,
                      onClose: () => _toggleSearch(false),
                    )
                  : TopNavigationBar(
                      searchHint: AppStrings.searchReportsHint,
                      onSearchTap: () => _toggleSearch(true),
                    ),
            ),

            // ── Search History (Optional) ──
            if (isSearching && searchHistory.isNotEmpty)
              Positioned(
                top: kToolbarHeight,
                left: 0,
                right: 0,
                child: Container(
                  color: AppColors.white,
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          AppStrings.searchHistory,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey),
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.borderColor),
                      Flexible(
                        child: ListView.builder(
                          itemCount: searchHistory.length,
                          itemBuilder: (_, index) {
                            final item = searchHistory[index];
                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  searchQuery = item;
                                });
                                _handleSearchSubmit();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                child: ReportCard(
                  title: "Total Working \nDays\n(This Month)",
                  value: "${viewModel.totalWorkingDays} days",
                  icon: Icons.date_range_outlined,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: ReportCard(
                  title: "Total Hours\nWorked",
                  value: "${viewModel.totalHoursWorked} hrs",
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
                child: ReportCard(
                  title: "Tasks\nCompleted",
                  value: "${viewModel.tasksCompleted}",
                  extraText: "this month",
                  icon: Icons.check_circle_outline,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHeightCard(
                child: ReportCard(
                  title: "Average Daily\nHours",
                  value: "${viewModel.averageDailyHours}",
                  extraText: "hrs/day",
                  icon: Icons.alarm_outlined,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildDailyLogTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.dailyLogTitle,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: const [
                    Expanded(
                        flex: 4,
                        child: Text(AppStrings.date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(
                        flex: 4,
                        child: Text(AppStrings.checkIn,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(
                        flex: 4,
                        child: Text(AppStrings.checkOut,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(
                        flex: 4,
                        child: Text(AppStrings.totalHours,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(
                        flex: 4,
                        child: Text(AppStrings.status,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DottedLine(
                  color: AppColors.lightGrey,
                ),
              ),
              ...viewModel.dailyLogs.asMap().entries.map((entry) {
                final index = entry.key;
                final log = entry.value;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Text(log.date,
                                  style: const TextStyle(fontSize: 12))),
                          Expanded(
                              flex: 4,
                              child: Text(log.checkIn,
                                  style: const TextStyle(fontSize: 12))),
                          Expanded(
                              flex: 4,
                              child: Text(log.checkOut,
                                  style: const TextStyle(fontSize: 12))),
                          Expanded(
                              flex: 4,
                              child: Text(log.totalHrs,
                                  style: const TextStyle(fontSize: 12))),
                          Expanded(
                            flex: 4,
                            child: Text(
                              log.status,
                              style: TextStyle(
                                color: log.status == "Present"
                                    ? AppColors.green
                                    : log.status == "Absent"
                                        ? AppColors.red
                                        : AppColors.orange,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index != viewModel.dailyLogs.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DottedLine(
                          color: AppColors.lightGrey,
                        ),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildReportChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.reportChartTitle,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.green),
              ),
            ),
            SizedBox(width: 5),
            Text(AppStrings.present, style: TextStyle(fontSize: 12)),
            SizedBox(width: 20),
            SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.red),
              ),
            ),
            SizedBox(width: 5),
            Text(AppStrings.absence, style: TextStyle(fontSize: 12)),
            SizedBox(width: 20),
            SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.blue),
              ),
            ),
            SizedBox(width: 5),
            Text(AppStrings.avgHrs, style: TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 2,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      const months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec'
                      ];
                      if (value.toInt() >= 0 && value.toInt() < months.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            months[value.toInt()],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: viewModel.present
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                      .toList(),
                  isCurved: true,
                  color: AppColors.green,
                  barWidth: 2,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: barData.color!,
                      strokeWidth: 0,
                    ),
                  ),
                ),
                LineChartBarData(
                  spots: viewModel.absence
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                      .toList(),
                  isCurved: true,
                  color: AppColors.red,
                  barWidth: 2,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: barData.color!,
                      strokeWidth: 0,
                    ),
                  ),
                ),
                LineChartBarData(
                  spots: viewModel.avgHrs
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value))
                      .toList(),
                  isCurved: true,
                  color: AppColors.blue,
                  barWidth: 2,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: barData.color!,
                      strokeWidth: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dotWidth;
  final double space;

  const DottedLine({
    this.height = 1,
    this.color = Colors.grey,
    this.dotWidth = 4,
    this.space = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dotCount = (boxWidth / (dotWidth + space)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dotCount, (_) {
            return Container(
              width: dotWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}
