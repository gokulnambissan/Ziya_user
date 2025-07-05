import '../models/report_log.dart';

class ReportViewModel {
  int totalWorkingDays = 22;
  int totalHoursWorked = 145;
  int tasksCompleted = 35;
  double averageDailyHours = 6.6;

  List<ReportLog> dailyLogs = [
    ReportLog(
      date: "June 21",
      checkIn: "09:15 AM",
      checkOut: "05:45 PM",
      totalHrs: "8.5 hrs",
      status: "Present",
    ),
    ReportLog(
      date: "June 22",
      checkIn: "--",
      checkOut: "--",
      totalHrs: "0 hrs",
      status: "Absent",
    ),
    ReportLog(
      date: "June 23",
      checkIn: "09:30 AM",
      checkOut: "04:00 PM",
      totalHrs: "6.5 hrs",
      status: "Half Day",
    ),
  ];

  List<int> present = [15, 16, 14, 15, 16, 17, 16, 17, 15, 16, 17, 18];
  List<int> absence = [5, 4, 6, 5, 4, 3, 4, 3, 5, 4, 3, 2];
  List<double> avgHrs = [6.0, 6.5, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.6, 6.7, 6.8, 6.9];
}
