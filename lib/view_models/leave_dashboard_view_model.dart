import 'package:intl/intl.dart';
import 'package:ziya_user/constants/leave_calender_constants.dart';

class LeaveDashboardViewModel {

  final int totalLeaveTaken      = 16;
  final int remainingLeave       = 29;
  final int pendingRequests      = 1;
  final int approvedLeaves       = 5;
  final int leaveBalance         = 8;
  final int rejectedLeaves       = 2;
  final int upcomingLeaves       = 1;
  final List<int> leavePerQuarter = [8, 6, 4, 2];


  String upcomingLeaveTitle   = "WFH";
  String formattedLeaveDates  = "01 July";

  final List<Map<String, String>> leaveRecords = [
    {
      'date'  : '10 June',
      'type'  : 'Sick Leave',
      'status': 'Approved',
      'reason': 'Fever',
    },
    {
      'date'  : '20 June',
      'type'  : 'Casual Leave',
      'status': 'Pending',
      'reason': 'Family Function',
    },
    {
      'date'  : '01 July',
      'type'  : 'WFH',
      'status': 'Rejected',
      'reason': 'No backup',
    },
  ];

  LeaveStatus? statusForDate(DateTime day) {
    final key = DateFormat('yyyy-MM-dd').format(day);
    return kDemoLeaveStatus[key];
  }
}
