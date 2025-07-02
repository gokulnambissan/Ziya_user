// attendance_page_body.dart

import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/attendance/attendance_detail_section.dart';
import 'package:ziya_user/view_models/attendance_view_model.dart';
import 'package:ziya_user/views/common/search_overlay.dart'
    show showSearchOverlay;
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class AttendancePageBody extends StatefulWidget {
  const AttendancePageBody({super.key});

  @override
  State<AttendancePageBody> createState() => _AttendancePageBodyState();
}

class _AttendancePageBodyState extends State<AttendancePageBody> {
  final AttendanceOverviewViewModel _overviewVM = AttendanceOverviewViewModel();
  final AttendanceViewModel _vm = AttendanceViewModel();
  final GlobalKey _searchKey = GlobalKey();
  String _searchHint = 'Search';

  DateTime _focusedDay = DateTime(2025, 6, 18);
  DateTime? _selectedDay;

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
          children: [
            _backLabel(context),
            const SizedBox(height: 12),
            _monthHeaderContainer(),
            const SizedBox(height: 8),
            _calendarContainer(),
            const SizedBox(height: 16),
            _overviewAndPieContainer(),
            const SizedBox(height: 16),
            const AttendanceDetailSection(), // ✅ Uses the new split widget
          ],
        ),
      ),
    );
  }

  Widget _backLabel(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios_new,
                size: 18, color: AppColors.black),
            const SizedBox(width: 6),
            const Text(
              'Attendance',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _monthHeaderContainer() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
              });
            },
          ),
          Text(
            DateFormat('MMMM yyyy').format(_focusedDay),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _calendarContainer() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarFormat: CalendarFormat.month,
        headerVisible: false,
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: const TextStyle(
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
          ),
          weekdayStyle: const TextStyle(
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
          ),
          dowTextFormatter: (date, locale) =>
              DateFormat.E(locale).format(date).toUpperCase(),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: _dayBuilder,
          selectedBuilder: _selectedBuilder,
        ),
      ),
    );
  }

  Widget _overviewAndPieContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _overviewRow(),
          const SizedBox(height: 16),
          _pieChartContainer(),
        ],
      ),
    );
  }

  Widget _overviewRow() {
    final tiles = <Widget>[];
    for (var i = 0; i < _overviewVM.items.length; i++) {
      tiles.add(Expanded(child: _buildCard(_overviewVM.items[i])));
      if (i != _overviewVM.items.length - 1) {
        tiles.add(const SizedBox(width: 8));
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiles,
    );
  }

  Widget _buildCard(OverviewItem item) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.label, style: TextStyle(color: item.color, fontSize: 14)),
          const SizedBox(height: 6),
          Text(item.number,
              style: TextStyle(
                  color: item.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _pieChartContainer() {
    return SizedBox(
      height: 280,
      child: PieChart(
        PieChartData(
          startDegreeOffset: 40,
          sections: [
            _pieSection(AppColors.green, 20, 'Present'),
            _pieSection(AppColors.red, 3, 'Absent'),
            _pieSection(AppColors.orange, 2, 'Leave'),
            _pieSection(AppColors.blue, 6, 'Late'),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _pieSection(Color color, int value, String label) {
    return PieChartSectionData(
      color: color,
      value: value.toDouble(),
      title: '${value.toString().padLeft(2, '0')}\ndays',
      radius: 65,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dayBuilder(BuildContext context, DateTime day, DateTime _) {
    return Container(
      width: 34,
      height: 34,
      child: Center(child: Text('${day.day}')),
    );
  }

  Widget _selectedBuilder(BuildContext context, DateTime day, DateTime _) {
    return Container(
      width: 34,
      height: 34,
      decoration:
          const BoxDecoration(color: AppColors.black, shape: BoxShape.circle),
      child: Center(
        child:
            Text('${day.day}', style: const TextStyle(color: AppColors.white)),
      ),
    );
  }
}
