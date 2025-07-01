import 'package:flutter/material.dart';

enum DayType { present, absent, leave, late }

class AttendanceRecord {
  final DateTime   date;
  final DayType    type;
  final TimeOfDay? checkIn;
  final TimeOfDay? checkOut;
  final String     workMode;
  final String     verification;
  final String?    notes;
  final double?    lat;
  final double?    lon;

  const AttendanceRecord({
    required this.date,
    required this.type,
    this.checkIn,
    this.checkOut,
    required this.workMode,
    required this.verification,
    this.notes,
    this.lat,
    this.lon,
  });
}
