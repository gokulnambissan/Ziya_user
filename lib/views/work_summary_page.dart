import 'package:flutter/material.dart';
import '../view_models/summary_view_model.dart';

class WorkSummaryPage extends StatelessWidget {
  final SummaryViewModel viewModel = SummaryViewModel();

  WorkSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          return viewModel.buildSummaryCard(viewModel.items[index]);
        },
      ),
    );
  }
}
