import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/task_model.dart';
import '../../constants/app_colors.dart';

class TrackerViewModel {
  final List<TaskModel> tasks = [
    TaskModel(
        title: "Responsive Design",
        dueDate: "18-06-2025",
        statusIndex: 1,
        progress: 0.45,
        daysRemaining: 2,
        assignedBy: "optional",
        priority: "Medium"),
    TaskModel(
        title: "UI/UX Design Implementation",
        dueDate: "18-06-2025",
        statusIndex: 2,
        progress: 0.65,
        daysRemaining: 2,
        assignedBy: "optional",
        priority: "High"),
    TaskModel(
        title: "Back-end Development",
        dueDate: "18-06-2025",
        statusIndex: 1,
        progress: 0.75,
        daysRemaining: 2,
        assignedBy: "optional",
        priority: "High"),
  ];

  final List<String> statuses = [
    "Not Started",
    "In Progress",
    "Completed",
    "Overdue"
  ];
  final List<String> actions = ["Start", "Update", "Complete"];

  final Map<String, Color> priorityColors = {
    "Low": AppColors.grey,
    "Medium": AppColors.dashboardTeal,
    "High": AppColors.red,
  };

  final Map<int, String> selectedActions = {};

  void updateSelectedAction(int index, String value) {
    selectedActions[index] = value;
  }

  Widget buildTaskCard({
    required TaskModel task,
    required int index,
    required String? selectedAction,
    required Function(String) onActionChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 30, 245, 37),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Due: ${task.dueDate}",
                style: const TextStyle(fontSize: 10, color: AppColors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text("Status: ",
              style: TextStyle(
                  fontSize: 12,
                ),),
              ...List.generate(statuses.length, (i) {
                final isActive = task.statusIndex == i;
                final statusColor = isActive
                    ? (statuses[i] == "Overdue"
                        ? AppColors.red
                        : AppColors.green)
                    : Colors.grey;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8, color: statusColor),
                    const SizedBox(width: 3),
                    Text(
                      statuses[i],
                      style: TextStyle(fontSize: 9, color: AppColors.black),
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 12),

          /// Progress & Metadata
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Progress : ",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              CircularPercentIndicator(
                radius: 15.0,
                lineWidth: 5.0,
                percent: task.progress,
                center: Text(
                  "${(task.progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                progressColor: AppColors.green,
                backgroundColor: AppColors.grey,
              ),
              const SizedBox(width: 30),
              Row(
                children: [
                  const Icon(Icons.timer, size: 14, color: AppColors.orange),
                  const SizedBox(width: 3),
                  Text(
                    "${task.daysRemaining} days \nremaining",
                    style:
                        const TextStyle(color: AppColors.orange, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Row(
                children: const [
                  Icon(Icons.create_outlined, size: 14, color: AppColors.black),
                  SizedBox(width: 4),
                  Text(
                    "Assigned By\n(optional)",
                    style: TextStyle(fontSize: 10, color: AppColors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Priority
          Row(
            children: [
              const Text("Priority: ",
              style: TextStyle(
                  fontSize: 12,
                ),),
              const SizedBox(width: 8),
              ...["Low", "Medium", "High"].map((level) {
                final isCurrent = task.priority == level;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:23),
                  child: Text(
                    level,
                    style: TextStyle(
                      color:
                          isCurrent ? priorityColors[level] : AppColors.black,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          const SizedBox(height: 12),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 50,
            children: actions.map((action) {
              Color dotColor = AppColors.black;

              if (task.title == "Responsive Design" && action == "Complete") {
                dotColor = AppColors.green;
              } else if (task.title == "UI/UX Design Implementation" &&
                  action == "Update") {
                dotColor = AppColors.green;
              } else if (task.title == "Back-end Development" &&
                  action == "Start") {
                dotColor = AppColors.green;
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(
                          255, 218, 218, 218), // light grey background
                      // ✅ Border removed!
                    ),
                    child: Center(
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dotColor, // inner dot
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    action,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget buildDottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          const dotWidth = 4.0;
          const spacing = 4.0;
          final dotCount = (width / (dotWidth + spacing)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dotCount, (_) {
              return const SizedBox(
                width: dotWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.black),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
