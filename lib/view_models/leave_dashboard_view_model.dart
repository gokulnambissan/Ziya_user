import 'package:intl/intl.dart';

class LeaveDashboardViewModel {
  final int totalLeaveTaken = 16;
  final int remainingLeave = 29;
  final int pendingRequests = 1;
  final int teamMembersOnLeave = 2;
  final double approvalRate = 92.0;
  final List<int> leavePerQuarter = [4,3,2,1];

  final String upcomingLeaveTitle = "Annual Leave";
  final DateTime upcomingFrom = DateTime(2025, 4, 22);
  final DateTime upcomingTo = DateTime(2025, 4, 24);

  int get upcomingLeaveDuration => upcomingTo.difference(upcomingFrom).inDays + 1;

  String get formattedLeaveDates {
    final format = DateFormat("MMM dd, yyyy");
    return "${format.format(upcomingFrom)} to ${format.format(upcomingTo)} ($upcomingLeaveDuration days)";
  }
}
