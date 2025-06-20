import 'package:flutter/material.dart';
import '../view_models/summary_view_model.dart';

class WorkSummaryPage extends StatelessWidget {
  const WorkSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = SummaryViewModel();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
            children:
                viewModel.items.map(viewModel.buildSummaryCard).toList(),
          ),
        ],
      ),
    );
  }
}
