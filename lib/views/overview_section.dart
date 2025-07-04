import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/overview_section_viewmodel.dart';
import '../constants/app_colors.dart';

class OverviewSection extends StatefulWidget {
  const OverviewSection({super.key});

  @override
  State<OverviewSection> createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> {
  final OverviewSectionViewModel viewModel = OverviewSectionViewModel();

  Widget buildCard(OverviewItem item) {
  return Expanded(
    child: Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.label,
            style: TextStyle(
              color: item.color, 
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.number,
            style: TextStyle(
              color: item.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: viewModel.items.map(buildCard).toList(),
    );
  }
}
