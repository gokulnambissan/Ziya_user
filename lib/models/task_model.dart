class TaskModel {
  final String title;
  final String dueDate;
  final int statusIndex;
  final double progress;
  final int daysRemaining;
  final String assignedBy;
  final String priority;

  TaskModel({
    required this.title,
    required this.dueDate,
    required this.statusIndex,
    required this.progress,
    required this.daysRemaining,
    required this.assignedBy,
    required this.priority,
  });
}
