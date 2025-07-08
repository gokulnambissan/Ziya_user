class NotificationModel {
  final String title;
  final String message;
  final NotificationType type;

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
  });
}

enum NotificationType {
  missedPunch,
  lateAttendance,
  dailySummary,
  leaveApproval,
  leaveRejection,
  shiftUpdate,
}
