import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class OngoingPendingPage extends StatelessWidget {
  const OngoingPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTaskCard(
            title: AppStrings.uiuxDesign,
            progress: "80% Done",
            status: AppStrings.ongoingTask,
            statusColor: AppColors.blue,
            priority: "High",
            priorityColor: AppColors.red,
            buttonLabel: AppStrings.makeAsDone,
          ),
          buildDottedDivider(),
          _buildTaskCard(
            title: AppStrings.responsiveDesign,
            progress: "45% Done",
            status: AppStrings.pendingTask,
            statusColor: AppColors.orange,
            priority: "Medium",
            priorityColor: AppColors.orange,
            buttonLabel: AppStrings.startTask,
          ),
          buildDottedDivider(),
          _buildTaskCard(
            title: AppStrings.backendDevelopment,
            progress: "75% Done",
            status: AppStrings.ongoingTask,
            statusColor: AppColors.blue,
            priority: "High",
            priorityColor: AppColors.red,
            buttonLabel: AppStrings.markAsDone,
          ),
          buildDottedDivider(),
          _buildTaskCard(
            title: AppStrings.serverSideLogic,
            progress: "75% Done",
            status: AppStrings.pendingTask,
            statusColor: AppColors.orange,
            priority: "Low",
            priorityColor: AppColors.priorityLow,
            buttonLabel: AppStrings.markAsDone,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String progress,
    required String status,
    required Color statusColor,
    required String priority,
    required Color priorityColor,
    required String buttonLabel,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text(progress,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(children: [
            const Text(AppStrings.status),
            Text(status,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 6),
          const Text("${AppStrings.assignedDate}12-05-2025"),
          const Text("${AppStrings.dueDate}12-06-2025"),
          const SizedBox(height: 6),
          Row(children: [
            const Text(AppStrings.priority),
            Text(priority,
                style: TextStyle(color: priorityColor, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(buttonLabel),
            ),
          ),
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
