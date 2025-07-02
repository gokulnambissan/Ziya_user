import 'package:flutter/material.dart';

enum DayType { present, absent, leave, late }

class AttendanceRecord {
  final DateTime   date;
  final DayType    type;
  final TimeOfDay? checkIn;
  final TimeOfDay? checkOut;
  final double?    lat;
  final double?    lon;
  final String?    notes;
  final String     workMode;
  final String     verificationType;

  const AttendanceRecord({
    required this.date,
    required this.type,
    this.checkIn,
    this.checkOut,
    this.lat,
    this.lon,
    this.notes,
    this.workMode        = 'Office',
    this.verificationType = 'Selfie',
  });

  double get locationLat => lat ?? 0;
  double get locationLng => lon ?? 0;
}
