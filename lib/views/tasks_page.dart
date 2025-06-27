import 'package:flutter/material.dart';
import '../view_models/tasks_view_model.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = TasksViewModel();
    final tasks = viewModel.tasks;

    return Column(
      children: List.generate(tasks.length * 2 , (i) {
        if (i.isOdd) {
          return viewModel.buildDottedDivider();
        } else {
          return viewModel.buildTaskCard(tasks[i ~/ 2]);
        }
      }),
    );
  }
}
