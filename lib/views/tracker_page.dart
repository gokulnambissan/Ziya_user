import 'package:flutter/material.dart';
import '../view_models/tracker_view_model.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  late TrackerViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = TrackerViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(viewModel.tasks.length * 2 , (i) {
          if (i.isOdd) {
            return viewModel.buildDottedDivider();
          } else {
            final index = i ~/ 2;
            final task = viewModel.tasks[index];
            final selectedAction = viewModel.selectedActions[index];

            return viewModel.buildTaskCard(
              task: task,
              index: index,
              selectedAction: selectedAction,
              onActionChanged: (value) {
                setState(() {
                  viewModel.updateSelectedAction(index, value);
                });
              },
            );
          }
        }),
      ),
    );
  }
}
