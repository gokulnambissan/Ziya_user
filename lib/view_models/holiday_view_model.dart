import 'package:flutter/material.dart';

class HolidayViewModel extends ChangeNotifier {
  int totalHolidays = 18;
  int upcomingHolidays = 4;
  final int remainingLeave = 29;

  List<int> publicHolidays = [3, 12];
  List<int> optionalHolidays = [20];
  List<int> companyHolidays = [16, 17, 25];

  double get holidayProgress => totalHolidays / 20;

  void updateHolidays({
    int? total,
    int? upcoming,
    List<int>? publicDays,
    List<int>? optionalDays,
    List<int>? companyDays,
  }) {
    if (total != null) totalHolidays = total;
    if (upcoming != null) upcomingHolidays = upcoming;
    if (publicDays != null) publicHolidays = publicDays;
    if (optionalDays != null) optionalHolidays = optionalDays;
    if (companyDays != null) companyHolidays = companyDays;
    notifyListeners();
  }
}
