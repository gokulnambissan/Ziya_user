import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/leave_calender_constants.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/leave_dashboard_view_model.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:ziya_user/views/common/inline_search_bar.dart';

class LeaveStatusPageBody extends StatefulWidget {
  const LeaveStatusPageBody({super.key});

  @override
  State<LeaveStatusPageBody> createState() => _LeaveStatusPageBodyState();
}

class _LeaveStatusPageBodyState extends State<LeaveStatusPageBody> {
  final LeaveDashboardViewModel viewModel = LeaveDashboardViewModel();

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
    // Optional: implement your actual filter/search logic here.
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
            // Content
            Positioned.fill(
              top: kToolbarHeight,
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

            // Top Bar / Inline Search
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: isSearching
                  ? InlineSearchBar(
                      query: searchQuery,
                      onQueryChanged: (val) => setState(() => searchQuery = val),
                      onSubmit: _handleSearchSubmit,
                      onClose: () => _toggleSearch(false),
                    )
                  : TopNavigationBar(
                      searchHint: 'Search leaves...',
                      onSearchTap: () => _toggleSearch(true),
                    ),
            ),

            // Search History
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
                          'Search History',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: AppColors.grey),
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
                  title: "Leave Balance",
                  value: "${viewModel.leaveBalance} days",
                  subtitle: "${viewModel.remainingLeave} days remaining",
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
                  subtitle: "${viewModel.remainingLeave} days remaining",
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
                  value: "${viewModel.rejectedLeaves} leaves",
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

  Widget _buildCalendar() {
    final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final daysInMonth = List<int>.generate(30, (index) => index + 1);

    final firstDay = DateTime(2025, 6, 1);
    final blanks = firstDay.weekday % 7;

    final items = [...List.generate(blanks, (_) => null), ...daysInMonth];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final day = items[index];
              if (day == null) return const SizedBox();

              final date = DateTime(2025, 6, day);
              final status = viewModel.statusForDate(date);

              Color bgColor;
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
                    fontSize: 12,
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
    final data = viewModel.leavePerQuarter;
    final max = data.reduce((a, b) => a > b ? a : b);
    const quarters = ["Q1", "Q2", "Q3", "Q4"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Leave Overview",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text("Your leave distribution for the current year",
        style: TextStyle(fontSize: 12),),
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
                      final index = value.toInt();
                      return (index >= 0 && index < quarters.length)
                          ? Text(quarters[index],
                              style: const TextStyle(fontSize: 10))
                          : const Text('');
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
                  Text("Leave days taken",style: TextStyle(fontSize: 12),),
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
                "Total days: ${data.reduce((a, b) => a + b)}",style: TextStyle(fontSize: 12)),
            Text("Remaining: ${viewModel.remainingLeave}",style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingLeave() {
    Widget cell(String text,
        {TextStyle? style,
        EdgeInsets padding =
            const EdgeInsets.symmetric(vertical: 14, horizontal: 8)}) {
      return Padding(
        padding: padding,
        child: Text(
          text,
          style: style ??
              const TextStyle(
                fontSize: 12,
                color: AppColors.black,
              ),
        ),
      );
    }

    final header = TableRow(children: [
      cell('Date',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
      cell('Leave Type',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
      cell('Status',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
      cell('Reason',
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w600,fontSize: 12)),
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
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
