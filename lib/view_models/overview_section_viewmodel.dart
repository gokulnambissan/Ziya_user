import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class OverviewItem {
  final String number;
  final Color color;
  final String label;

  OverviewItem({
    required this.number,
    required this.color,
    required this.label,
  });
}

class OverviewSectionViewModel {
  List<OverviewItem> items = [
    OverviewItem(number: "20", color: AppColors.green, label: "Presence"),
    OverviewItem(number: "03", color: AppColors.red, label: "Absence"),
    OverviewItem(number: "02", color: AppColors.orange, label: "Leave"),
  ];
}
