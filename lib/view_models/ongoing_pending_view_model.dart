import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/view_models/tasks_view_model.dart';

class OngoingPendingTask {
  final String title;
  final String progress;
  final String status;
  final Color statusColor;
  final String priority;
  final Color priorityColor;
  final String buttonLabel;

  OngoingPendingTask({
    required this.title,
    required this.progress,
    required this.status,
    required this.statusColor,
    required this.priority,
    required this.priorityColor,
    required this.buttonLabel,
  });
}

class OngoingPendingViewModel {
  final List<OngoingPendingTask> tasks = [
    OngoingPendingTask(
      title: "UI/UX Design ",
      progress: "80% Done",
      status: "Ongoing Task",
      statusColor: Colors.blue,
      priority: "High",
      priorityColor: Colors.red,
      buttonLabel: "Make as Done",
    ),
    OngoingPendingTask(
      title: "Responsive Design",
      progress: "45% Done",
      status: "Pending Task",
      statusColor: Colors.orange,
      priority: "Medium",
      priorityColor: Colors.orange,
      buttonLabel: "Start Task",
    ),
    OngoingPendingTask(
      title: "Backend Development",
      progress: "75% Done",
      status: "Ongoing Task",
      statusColor: Colors.blue,
      priority: "High",
      priorityColor: Colors.red,
      buttonLabel: "Mark as Done",
    ),
    OngoingPendingTask(
      title: "Server Side Logic",
      progress: "75% Done",
      status: "Pending Task",
      statusColor: Colors.orange,
      priority: "Low",
      priorityColor: Colors.grey,
      buttonLabel: "Mark as Done",
    ),
  ];

  Widget buildTaskCard(OngoingPendingTask task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(task.title,
                style: const TextStyle(
                    color: Color.fromARGB(255, 30, 245, 37),
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            Text(task.progress, style: const TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            const Text("Status: "),
            Text(task.status,
                style: TextStyle(color: task.statusColor, fontWeight: FontWeight.bold,fontSize: 12)),
          ]),
          const SizedBox(height: 6),
          Row(
  children: const [
    Text(
      "Assigned Date: ",
      style: TextStyle(fontSize: 13,color: AppColors.black),
    ),
    Text(
      "12-05-2025",
      style: TextStyle(fontSize: 11,color: AppColors.black), 
    ),
  ],
),

SizedBox(height: 4),

Row(
  children: const [
    Text(
      "Due Date: ",
      style: TextStyle(fontSize: 13,color: AppColors.black),
    ),
    Text(
      "12-06-2025",
      style: TextStyle(fontSize: 11,color: AppColors.black), 
    ),
  ],
),

          const SizedBox(height: 6),
          Row(children: [
            const Text("Priority: ",
            style: TextStyle(fontSize: 13,color: AppColors.black),),
            Text(task.priority,
                style: TextStyle(color: task.priorityColor, fontWeight: FontWeight.bold,fontSize: 12)),
          ]),
          const SizedBox(height: 3),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Text(task.buttonLabel,
              style: TextStyle(fontSize: 11),),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDottedDivider() => TasksViewModel().buildDottedDivider();
}
