import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/view_models/attendance_view_model.dart';
import 'package:ziya_user/views/common/inline_search_widget.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/models/attendance_record.dart';
import 'package:ziya_user/views/attendance/attendance_detail_section.dart';

class AttendancePageBody extends StatefulWidget {
  const AttendancePageBody({super.key});

  @override
  State<AttendancePageBody> createState() => _AttendancePageBodyState();
}

class _AttendancePageBodyState extends State<AttendancePageBody> {
  final AttendanceViewModel _attendanceVM = AttendanceViewModel();
  DateTime _focusedDay = DateTime(2025, 6, 18);
  DateTime? _selectedDay;

  void _handleSearch(String query) {
    debugPrint('Attendance search triggered: $query');
    // TODO: Add your real search filter here if needed
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
                            'Attendance Calendar',
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
                    _monthHeaderContainer(),
                    const SizedBox(height: 10),
                    _calendarContainer(),
                    const SizedBox(height: 14),
                    _overviewContainer(),
                    const SizedBox(height: 14),
                    const AttendanceDetailSection(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: InlineSearchWidget(
                searchHint: 'Search attendance...',
                onSubmitQuery: _handleSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _monthHeaderContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: _monthHeader(),
    );
  }

  Widget _monthHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 12),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
            });
          },
        ),
        Text(
          DateFormat('MMMM yyyy').format(_focusedDay),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 12),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _calendarContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: _calendar(),
    );
  }

  Widget _calendar() {
    return TableCalendar(
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
      daysOfWeekHeight: 30,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.blue,
          fontSize: 10,
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.blue,
          fontSize: 10,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day).toUpperCase();
          return Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
                fontSize: 10,
              ),
            ),
          );
        },
        defaultBuilder: _dayBuilder,
        selectedBuilder: _selectedBuilder,
      ),
    );
  }

  Widget _dayBuilder(BuildContext context, DateTime day, DateTime _) {
    final rec = _attendanceVM.recordFor(day);

    if (rec != null) {
      Color color;
      switch (rec.type) {
        case DayType.present:
          color = const Color.fromARGB(255, 25, 221, 32);
          break;
        case DayType.absent:
          color = const Color.fromARGB(255, 252, 25, 9);
          break;
        case DayType.leave:
          color = const Color.fromARGB(255, 255, 136, 0);
          break;
        case DayType.late:
          color = const Color.fromARGB(255, 85, 176, 250);
          break;
      }

      return Center(
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${day.day}',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Text(
        '${day.day}',
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _selectedBuilder(BuildContext context, DateTime day, DateTime _) {
    return Center(
      child: Container(
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _overviewContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Overview',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: _attendanceVM.overviewItems
                .map((item) => Expanded(child: _overviewCard(item)))
                .toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                startDegreeOffset: 40,
                sections: _attendanceVM.overviewItems
                    .map((e) => PieChartSectionData(
                          value: double.parse(e.number),
                          color: e.color,
                          title: '${e.number}\nDays',
                          radius: 60,
                          titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w500),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewCard(OverviewItem item) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(item.label,
              style: TextStyle(color: item.color, fontWeight: FontWeight.bold,fontSize: 12)),
          const SizedBox(height: 4),
          Text(item.number,
              style: TextStyle(color: item.color, fontWeight: FontWeight.w600,fontSize: 14)),
        ],
      ),
    );
  }
}
