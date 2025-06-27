import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

/// Card with fixed height (for dashboard stats)
class FixedHeightCard extends StatelessWidget {
  final Widget child;

  const FixedHeightCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEDEDED),
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Card with dynamic height (adapts to content)
class DynamicHeightCard extends StatelessWidget {
  final Widget child;

  const DynamicHeightCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEDEDED),
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Reusable stat card
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final String? extraText; 
  final bool showProgress;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    this.extraText,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Icon(icon, size: 30, color: AppColors.dashboardTeal),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (extraText != null) 
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  extraText!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.black,
                  ),
                ),
              ),
          ],
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.black,
          ),
        ),
        if (showProgress)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey.shade300,
              color: AppColors.blue,
              minHeight: 5,
            ),
          ),
      ],
    );
  }
}
