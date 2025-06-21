import 'package:flutter/material.dart';
import '../view_models/summary_view_model.dart';

class WorkSummaryPage extends StatelessWidget {
  final SummaryViewModel viewModel = SummaryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Work Summary")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3, // Adjust for card size
            ),
            itemBuilder: (context, index) {
              return viewModel.buildSummaryCard(viewModel.items[index]);
            },
          ),
        ),
      ),
    );
  }
}
