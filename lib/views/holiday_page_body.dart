import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/constants/stat_card_wigets.dart';
import 'package:ziya_user/view_models/holiday_view_model.dart';
import 'package:ziya_user/views/common/search_overlay.dart'
    show showSearchOverlay;
import 'package:ziya_user/views/common/top_navigation_bar.dart';

class HolidayPageBody extends StatefulWidget {
  const HolidayPageBody({super.key});

  @override
  State<HolidayPageBody> createState() => _HolidayPageBodyState();
}

class _HolidayPageBodyState extends State<HolidayPageBody> {
  final HolidayViewModel viewModel = HolidayViewModel();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHolidayGrid(),
            const SizedBox(height: 16),
            _buildLegendRow(),
            const SizedBox(height: 16),
            _buildCalendar(),
            const SizedBox(height: 16),
            _buildHolidayTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FixedHolidayCard(
                child: HolidayCard(
                  title: "Total \nHolidays",
                  value: "${viewModel.totalHolidays} days",
                  subtitle: "in a year",
                  icon: Icons.date_range_outlined,
                  showProgress: true,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FixedHolidayCard(
                child: HolidayCard(
                  title: "Upcoming \nHolidays",
                  value: "${viewModel.upcomingHolidays}",
                  extraText: "(Bakrid - 17 June)",
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

  Widget _buildLegendRow() {
    return Row(
      children: [
        _buildLegendItem(Colors.green, "Public"),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.yellow, "Optional"),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.blue, "Company"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildCalendar() {
    final daysInJune = List<int>.generate(30, (index) => index + 1);
    final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daysInJune.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final day = daysInJune[index];
              Color? bgColor;
              if (viewModel.publicHolidays.contains(day)) {
                bgColor = AppColors.green;
              } else if (viewModel.optionalHolidays.contains(day)) {
                bgColor = AppColors.yellow;
              } else if (viewModel.companyHolidays.contains(day)) {
                bgColor = AppColors.blue;
              }
              final isSunday = index % 7 == 0;
              return Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: bgColor ?? AppColors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 14,
                  color: bgColor == null
                      ? (isSunday ? Colors.red : AppColors.black)
                      : AppColors.white,),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey[300]!),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(3),
        },
        children: [
          _buildTableRow(
            ["Date", "17 June", "15 August", "23 October"],
            isHeader: true,
          ),
          _buildTableRow(
            ["Day", "Tuesday", "Thursday", "Wednesday"],
          ),
          _buildTableRow(
            ["Holiday Name", "Bakrid", "Independence Day", "Diwali"],
          ),
          _buildTableRow(
            ["Type", "Public Holiday", "National Holiday", "Optional"],
          ),
          _buildTableRow(
            ["Note", "Company-wide holiday", "Paid Leave", "Can be applied"],
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.asMap().entries.map((entry) {
        final index = entry.key;
        final cell = entry.value;

        final bool isFirstColumn = index == 0;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            cell,
            style: TextStyle(
              fontWeight: isFirstColumn ? FontWeight.bold : FontWeight.normal,
              color: isFirstColumn ? AppColors.blue : AppColors.black,
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
    );
  }
}
