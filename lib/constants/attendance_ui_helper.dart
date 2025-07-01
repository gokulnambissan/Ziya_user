import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Common white container used throughout the attendance screen.
Widget attendanceWhiteBox({
  required EdgeInsetsGeometry margin,
  required EdgeInsetsGeometry padding,
  required Widget child,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: attendanceBoxDecoration(),
    child: child,
  );
}

/// BoxDecoration token shared by all white cards.
BoxDecoration attendanceBoxDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.borderColor),
      boxShadow: const [
        BoxShadow(
          color: AppColors.black, // subtle grey shadow
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    );

/// Month name helper (1 → “January”, 2 → “February”…)
String monthName(int m) => const [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][m];

/// Pretty “hh:mm AM/PM” formatter for TimeOfDay.
String formatTimeOfDay(TimeOfDay t) {
  final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final m = t.minute.toString().padLeft(2, '0');
  final suf = t.period == DayPeriod.am ? 'AM' : 'PM';
  return '$h:$m $suf';
}
