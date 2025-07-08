import 'package:ziya_user/models/notification_model.dart';


class NotificationsViewModel {
  List<NotificationModel> notifications = [];

  NotificationsViewModel() {
    // Preload notifications
    notifications = [
      NotificationModel(
        title: "Missed Punch",
        message:
            "Missed Clock-in Detected. Please update your attendance or contact HR.",
        type: NotificationType.missedPunch,
      ),
      NotificationModel(
        title: "Late Attendance",
        message:
            "You’re running late! Your clock-in time is beyond the scheduled shift start.",
        type: NotificationType.lateAttendance,
      ),
      NotificationModel(
        title: "Daily Summary",
        message:
            "Your attendance today: Clock-in at 9:12 AM, Clock-out at 6:05 PM. Total hours: 8.53",
        type: NotificationType.dailySummary,
      ),
      NotificationModel(
        title: "Leave Approved",
        message:
            "Your leave request for June 15 has been approved. Enjoy your day off!",
        type: NotificationType.leaveApproval,
      ),
      NotificationModel(
        title: "Leave Rejection",
        message:
            "Leave request declined. Please check with your manager for details.",
        type: NotificationType.leaveRejection,
      ),
      NotificationModel(
        title: "Shift Update",
        message:
            "Shift updated: New shift time is 10:00 AM – 7:00 PM, effective from June 14.",
        type: NotificationType.shiftUpdate,
      ),
    ];
  }
}
