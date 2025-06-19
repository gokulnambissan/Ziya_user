import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ziya_user/models/task_model.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  final List<TaskModel> tasks = [
    TaskModel(
      title: "Responsive Design",
      dueDate: "18-06-2025",
      statusIndex: 1,
      progress: 0.45,
      daysRemaining: 2,
      assignedBy: "optional",
      priority: "Medium",
    ),
    TaskModel(
      title: "UI/UX Design Implementation",
      dueDate: "18-06-2025",
      statusIndex: 2,
      progress: 0.65,
      daysRemaining: 2,
      assignedBy: "optional",
      priority: "High",
    ),
    TaskModel(
      title: "Back-end Development",
      dueDate: "18-06-2025",
      statusIndex: 1,
      progress: 0.75,
      daysRemaining: 2,
      assignedBy: "optional",
      priority: "High",
    ),
  ];

  final List<String> statuses = [
    "Not Started",
    "In Progress",
    "Completed",
    "Overdue"
  ];
  final Map<String, Color> priorityColors = {
    "Low": Colors.grey,
    "Medium": Colors.teal,
    "High": Colors.red,
  };

  final List<String> actions = ["Start", "Update", "Complete"];

  // Track selected action per task by index
  final Map<int, String> selectedActions = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(tasks.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Insert divider between task cards
          return buildDottedDivider();
        } else {
          // Index of task
          final index = i ~/ 2;
          final task = tasks[index];
          final selectedAction = selectedActions[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(task.title,
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("Due Date: ${task.dueDate}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),

                /// Status Row
                Row(
                  children: [
                    const Text("Status: "),
                    ...List.generate(statuses.length, (i) {
                      final isActive = task.statusIndex == i;
                      return Row(
                        children: [
                          Icon(Icons.circle,
                              size: 10,
                              color: isActive ? Colors.green : Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            statuses[i],
                            style: TextStyle(
                                fontSize: 12,
                                color: isActive ? Colors.green : Colors.grey),
                          ),
                          const SizedBox(width: 10),
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 12),

                /// Progress, Days, Assigned
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 6.0,
                      percent: task.progress,
                      center: Text("${(task.progress * 100).toInt()}%"),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timer, size: 20, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text("${task.daysRemaining} days remaining",
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 13)),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.person_outline,
                            size: 20, color: Colors.black54),
                        SizedBox(width: 4),
                        Text("Assigned By\n(optional)",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                /// Priority
                Row(
                  children: [
                    const Text("Priority: "),
                    const SizedBox(width: 8),
                    ...["Low", "Medium", "High"].map((level) {
                      final isCurrent = task.priority == level;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          level,
                          style: TextStyle(
                            color:
                                isCurrent ? priorityColors[level] : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
                const SizedBox(height: 12),

                /// Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: actions.map((action) {
                    return Row(
                      children: [
                        Radio<String>(
                          value: action,
                          groupValue: selectedAction,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              selectedActions[index] = value!;
                            });
                          },
                        ),
                        Text(action,
                            style: const TextStyle(color: Colors.black)),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }
      }),
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
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
