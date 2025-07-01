import 'package:ziya_user/constants/leave_calender_constants.dart';

class LeaveCalendarViewModel {
  final DateTime focusedDay = DateTime(2025, 6, 15); // Always June
  DateTime? selectedDay;

  final Map<String, LeaveStatus> _statusMap = kDemoLeaveStatus;

  LeaveStatus? statusFor(DateTime day) {
    final key =
        '${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
    return _statusMap[key];
  }

  void selectDay(DateTime selected) {
    selectedDay = selected;
  }
}
