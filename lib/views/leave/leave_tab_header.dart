import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class LeaveTabHeader extends StatelessWidget {
  final int selectedTab;
  final void Function(int) onTabSelected;

  const LeaveTabHeader({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.white,
      child: Row(
        children: [
          _buildTabButton("Dashboard", 0, Icons.dashboard_customize_outlined),
          _buildTabButton("Request Leave", 1, Icons.disc_full_outlined),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index, IconData icon) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: isSelected
                ? const Border(bottom: BorderSide(width: 3, color: Colors.blue))
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? AppColors.blue : AppColors.grey),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.blue : AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
