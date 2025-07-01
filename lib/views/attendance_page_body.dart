// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_user/views/common/search_overlay.dart';
import 'package:ziya_user/views/common/top_navigation_bar.dart';
import '../../constants/app_colors.dart';
import '../../view_models/attendance_view_model.dart';
import '../../models/attendance_record.dart';
import 'package:ziya_user/constants/attendance_ui_helper.dart' as ui;     


class AttendancePageBody extends StatefulWidget {
  const AttendancePageBody({super.key});

  @override
  State<AttendancePageBody> createState() => _AttendancePageBodyState();
}

class _AttendancePageBodyState extends State<AttendancePageBody> {
  final AttendanceViewModel _vm = AttendanceViewModel();
  late DateTime _focusedDay;
  DateTime? _selectedDay;

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
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(
        onSearchTap: _handleSearchTap,
        searchBarKey: _searchKey,
        searchHint: _searchHint,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.chevron_left, size: 28),
                  ),
                  const SizedBox(width: 4),
                  const Text('Attendance Calendar',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
            ),


            ui.attendanceWhiteBox(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              child: _buildCalendar(),
            ),


            ui.attendanceWhiteBox(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: _buildOverview(),
            ),

            if (_selectedDay != null && _vm.recordFor(_selectedDay!) != null)
              ui.attendanceWhiteBox(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                padding: const EdgeInsets.all(16),
                child: _buildDetail(_vm.recordFor(_selectedDay!)!),
              ),
          ],
        ),
      ),
    );
  }


  Widget _buildCalendar() {
    return TableCalendar<AttendanceRecord>(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextFormatter: (d, _) => '${ui.monthName(d.month)} ${d.year}',
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
      eventLoader: (d) => _vm.recordFor(d) != null ? [_vm.recordFor(d)!] : [],
      onDaySelected: (sel, foc) => setState(() {
        _selectedDay = sel;
        _focusedDay = foc;
      }),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: _day,
        todayBuilder: _day,
        outsideBuilder: _day,
        selectedBuilder: _selectedDayBuilder,
      ),
    );
  }

  Widget _day(BuildContext _, DateTime day, DateTime __) {
    final rec = _vm.recordFor(day);
    Color? bg;
    switch (rec?.type) {
      case DayType.present:
        bg = AppColors.green.withOpacity(.3);
        break;
      case DayType.absent:
        bg = AppColors.red.withOpacity(.3);
        break;
      case DayType.leave:
        bg = AppColors.orange.withOpacity(.35);
        break;
      case DayType.late:
        bg = AppColors.blue.withOpacity(.35);
        break;
      default:
        bg = null;
    }
    return Center(
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Center(child: Text('${day.day}', style: const TextStyle(fontSize: 12))),
      ),
    );
  }

  Widget _selectedDayBuilder(BuildContext _, DateTime day, DateTime __) =>
      Center(
        child: Container(
          width: 38,
          height: 38,
          decoration:
              const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
          child: Center(
            child: Text('${day.day}',
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),
      );

  Widget _buildOverview() {
    final presence = _vm.count(DayType.present);
    final absence = _vm.count(DayType.absent);
    final leaves = _vm.count(DayType.leave);
    final late = _vm.count(DayType.late);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('Total Days : ${_vm.totalDays}',
            style: const TextStyle(color: AppColors.lightGrey)),
        const SizedBox(height: 12),
        Row(
          children: [
            _stat('Presence', presence, AppColors.green),
            _stat('Absence', absence, AppColors.red),
            _stat('Leaves', leaves, AppColors.orange),
            _stat('Late', late, AppColors.blue),
          ],
        ),
        const SizedBox(height: 24),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 60,
              sectionsSpace: 2,
              sections: [
                _pie(AppColors.green, presence, '20\nDays'),
                _pie(AppColors.red, absence, '03\nDays'),
                _pie(AppColors.orange, leaves, '02\nDays'),
                _pie(AppColors.blue, late, '06\nDays'),
              ],
            ),
          ),
        ),
      ],
    );
  }

 Widget _stat(String lbl, int val, Color c) => Expanded(
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: ui.attendanceBoxDecoration(), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(val.toString().padLeft(2, '0'),
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: c)),
              const SizedBox(height: 4),
              Text(lbl,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );

  PieChartSectionData _pie(Color c, int v, String txt) =>
      PieChartSectionData(
        color: c,
        value: v.toDouble(),
        radius: 80,
        title: txt,
        titleStyle: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        showTitle: v > 0,
      );

  Widget _buildDetail(AttendanceRecord rec) {
    final dateStr =
        '${ui.monthName(rec.date.month)} ${rec.date.day}, ${rec.date.year}';

    Color statusColor = switch (rec.type) {
      DayType.present => AppColors.green,
      DayType.absent => AppColors.red,
      DayType.leave => AppColors.orange,
      DayType.late => AppColors.blue,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dateStr,
            style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: statusColor, borderRadius: BorderRadius.circular(12)),
          child: Text(rec.type.name.toUpperCase(),
              style: const TextStyle(color: Colors.white)),
        ),
        Container(
            height: 1,
            color: AppColors.borderColor,
            margin: const EdgeInsets.symmetric(vertical: 20)),
        Row(children: [_clock('Check‑in', rec.checkIn), const Spacer(), _clock('Check‑out', rec.checkOut)]),
        const SizedBox(height: 16),
        Row(children: [_tag('Work Mode', rec.workMode), const Spacer(), _tag('Verification', rec.verification)]),
        const SizedBox(height: 16),
        if (rec.lat != null) _loc(rec.lat!, rec.lon!),
        if (rec.notes?.isNotEmpty ?? false) _note(rec.notes!),
      ],
    );
  }

  Column _clock(String lbl, TimeOfDay? t) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.alarm_on, size: 18, color: AppColors.green),
              const SizedBox(width: 4),
              Text(lbl,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          Text(t != null ? ui.formatTimeOfDay(t) : '--:--',
              style: const TextStyle(fontSize: 14, color: AppColors.green)),
        ],
      );

  Widget _tag(String title, String val) => Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: AppColors.lightGrey)),
            const SizedBox(height: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(val,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: AppColors.orange)),
            ),
          ],
        ),
      );

  Widget _loc(double lat, double? lon) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('Location',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Lat: ${lat.toStringAsFixed(2)}, '
              'Long: ${lon?.toStringAsFixed(2) ?? '--'}'),
        ],
      );

  Widget _note(String txt) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text('Notes',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(txt),
        ],
      );
}