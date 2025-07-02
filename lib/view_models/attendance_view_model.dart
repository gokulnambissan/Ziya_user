import 'package:flutter/material.dart';
import 'package:ziya_user/models/attendance_record.dart';

class AttendanceRecord {
  final DateTime date;
  final DayType type;
  final TimeOfDay? checkIn;
  final TimeOfDay? checkOut;
  final double? lat;
  final double? lon;
  final String? notes;

  AttendanceRecord({
    required this.date,
    required this.type,
    this.checkIn,
    this.checkOut,
    this.lat,
    this.lon,
    this.notes,
  });
}

class OverviewItem {
  final String label;
  final String number;
  final Color color;

  OverviewItem({
    required this.label,
    required this.number,
    required this.color,
  });
}

class AttendanceViewModel {
  final List<AttendanceRecord> _records = [];
  final List<OverviewItem> overviewItems = [
    OverviewItem(label: 'Presence', number: '20', color: Colors.green),
    OverviewItem(label: 'Absence', number: '3', color: Colors.red),
    OverviewItem(label: 'Leaves', number: '2', color: Colors.orange),
    OverviewItem(label: 'Late', number: '6', color: Colors.blue),
  ];

  final DateTime recDate = DateTime(2025, 6, 18);
  final String workMode = 'Office';
  final String verification = 'Selfie';
  final String notes = 'Worked On UI Bug Fixing';
  final double lat = 13.05;
  final double lon = 80.24;
  final TimeOfDay checkIn = const TimeOfDay(hour: 9, minute: 30);
  final TimeOfDay checkOut = const TimeOfDay(hour: 18, minute: 0);
  final DayType status = DayType.present;

  AttendanceViewModel() {
    _seedDemoData();
  }

  void _seedDemoData() {
    const presentDays = [9, 10, 16, 17, 18];
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
          lat: lat,
          lon: lon,
          notes: notes,
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

  List<AttendanceRecord> get records => _records;

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
