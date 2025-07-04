
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class LeaveTabHeaderPage extends StatelessWidget {
  const LeaveTabHeaderPage({
    super.key,
    required this.selectedTab, // 0 = Dashboard, 1 = Request Leave
    required this.onTabSelected,
  });

  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  static const _titles = ['Dashboard', 'Request Leave'];
  static const _icons = [Icons.dashboard_outlined, Icons.note_add_outlined];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: AppColors.black,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Leaves',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          color: Colors.grey[200], 
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: List.generate(_titles.length, (index) {
              final bool isActive = index == selectedTab;
              return Container(
                margin: index == 0
                    ? const EdgeInsets.only(right: 8)
                    : const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: isActive ? null : () => onTabSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color:AppColors.white
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _icons[index],
                          size: 14,
                          color: isActive ? AppColors.blue : AppColors.black,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _titles[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: isActive ? AppColors.blue : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
