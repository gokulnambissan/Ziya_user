

class LeaveDashboardViewModel {
  final int totalLeaveTaken = 16;
  final int remainingLeave = 29;
  final int pendingRequests = 1;
  final int teamMembersOnLeave = 2;
  final int approvedLeaves = 5;
  final int leaveBalance= 8;
  final int rejectedLeaves= 2;
  final int upcomingLeaves= 1;
  final List<int> leavePerQuarter = [4,3,2,1];
  
  String upcomingLeaveTitle = "WFH";
  String formattedLeaveDates = "01 July";

  final List<Map<String, String>> leaveRecords = [
    {
      'date': '10 June',
      'type': 'Sick Leave',
      'status': 'Approved',
      'reason': 'Fever',
    },
    {
      'date': '20 June',
      'type': 'Casual Leave',
      'status': 'Pending',
      'reason': 'Family Function',
    },
    {
      'date': '01 July',
      'type': 'WFH',
      'status': 'Rejected',
      'reason': 'No backup',
    },
  ];
}

