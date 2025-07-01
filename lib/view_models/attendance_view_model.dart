import 'package:flutter/material.dart';
import '../models/attendance_record.dart';

class AttendanceViewModel extends ChangeNotifier {

  final Map<DateTime, AttendanceRecord> _records = {
    DateTime.utc(2025, 6, 6): AttendanceRecord(
      date: DateTime.utc(2025, 6, 6),
      type: DayType.late,
      checkIn:  const TimeOfDay(hour: 10, minute: 20),
      checkOut: const TimeOfDay(hour: 18, minute: 0),
      workMode:  'Office',
      verification: 'Selfie',
      notes: 'Team demo day',
    ),
    DateTime.utc(2025, 6, 9): AttendanceRecord(
      date: DateTime.utc(2025, 6, 9),
      type: DayType.present,
      checkIn:  const TimeOfDay(hour: 9,  minute: 10),
      checkOut: const TimeOfDay(hour: 18, minute: 0),
      workMode:  'Office',
      verification: 'Selfie',
      notes: 'Sprint planning',
    ),
    DateTime.utc(2025, 6, 24): AttendanceRecord(
      date: DateTime.utc(2025, 6, 24),
      type: DayType.absent,
      workMode: 'N/A',
      verification: 'N/A',
      notes: 'Sick leave',
    ),
    DateTime.utc(2025, 6, 25): AttendanceRecord(
      date: DateTime.utc(2025, 6, 25),
      type: DayType.leave,
      workMode: 'N/A',
      verification: 'N/A',
      notes: 'Annual leave',
    ),
  };


  Map<DateTime, AttendanceRecord> get records => _records;

  AttendanceRecord? recordFor(DateTime d) =>
      _records[DateUtils.dateOnly(d)];

  int get totalDays => 31;

  int count(DayType t) =>
      _records.values.where((r) => r.type == t).length;
}
