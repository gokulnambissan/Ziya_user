import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/dashboard_item_viewmodel.dart';
import '../constants/app_colors.dart';


class DashboardItem extends StatelessWidget {
  final DashboardItemViewModel viewModel;

  const DashboardItem({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
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
          Icon(viewModel.icon, size: 32, color: viewModel.color),
          const SizedBox(height: 8),
          Text(
            viewModel.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
