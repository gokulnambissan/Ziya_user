import 'package:flutter/material.dart';
import '../view_models/ongoing_pending_view_model.dart';

class OngoingPendingPage extends StatelessWidget {
  const OngoingPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = OngoingPendingViewModel();
    final tasks = viewModel.tasks;

    return SingleChildScrollView(
      child: Column(
        children: List.generate(tasks.length * 2 - 1, (i) {
          if (i.isOdd) {
            return viewModel.buildDottedDivider();
          } else {
            return viewModel.buildTaskCard(tasks[i ~/ 2]);
          }
        }),
      ),
    );
  }
}
