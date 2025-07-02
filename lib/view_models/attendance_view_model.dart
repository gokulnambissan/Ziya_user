import 'package:ziya_user/constants/app_colors.dart';

import '../models/attendance_record.dart';
import 'package:flutter/material.dart';

class AttendanceViewModel {
  final List<AttendanceRecord> _records = [];

  AttendanceViewModel() {
    _seedDemoData();
  }

  void _seedDemoData() {
    const presentDays = [9, 10, 16, 17];
    const absentDays = [24];
    const leaveDays = [25];
    const lateDays = [6];

    DateTime _d(int day) => DateTime(2025, 6, day);

    for (final d in presentDays) {
      _records.add(
        AttendanceRecord(
          date: _d(d),
          type: DayType.present,
          checkIn: const TimeOfDay(hour: 9, minute: 30),
          checkOut: const TimeOfDay(hour: 18, minute: 0),
          lat: 13.05,
          lon: 80.24,
          notes: 'Worked On UI Bug Fixing',
        ),
      );
    }
    for (final d in absentDays) {
      _records.add(AttendanceRecord(date: _d(d), type: DayType.absent));
    }
    for (final d in leaveDays) {
      _records.add(AttendanceRecord(date: _d(d), type: DayType.leave));
    }
    for (final d in lateDays) {
      _records.add(
        AttendanceRecord(
          date: _d(d),
          type: DayType.late,
          checkIn: const TimeOfDay(hour: 10, minute: 30),
          checkOut: const TimeOfDay(hour: 19, minute: 0),
        ),
      );
    }
  }

  AttendanceRecord? recordFor(DateTime date) {
    for (final rec in _records) {
      if (rec.date.year == date.year &&
          rec.date.month == date.month &&
          rec.date.day == date.day) {
        return rec;
      }
    }
    return null;
  }

  int count(DayType type) => _records.where((r) => r.type == type).length;

}


class OverviewItem {
  final String number;
  final Color color;
  final String label;

  OverviewItem({
    required this.number,
    required this.color,
    required this.label,
  });
}

class AttendanceOverviewViewModel {
  final List<OverviewItem> items = [
    OverviewItem(number: "20", color: AppColors.green, label: "Presence"),
    OverviewItem(number: "03", color: AppColors.red, label: "Absence"),
    OverviewItem(number: "02", color: AppColors.orange, label: "Leaves"),
    OverviewItem(number: "06", color: AppColors.blue, label: "Late"),
  ];
}