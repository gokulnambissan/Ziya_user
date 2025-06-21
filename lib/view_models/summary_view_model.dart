import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import '../models/summary_model.dart';

class SummaryViewModel {
  final List<SummaryItem> items = [
    SummaryItem(title: "Total Working Days", value: "20", iconName: "calendar_today"),
    SummaryItem(title: "Total Hours worked", value: "160 hours", iconName: "access_time"),
    SummaryItem(title: "Average Daily Hours", value: "8.0 hours", iconName: "av_timer"),
    SummaryItem(title: "Productivity Indicator", value: "80%", iconName: "bar_chart"),
    SummaryItem(title: "Projects Involved", value: "Revenue\nDashboard", iconName: "person"),
    SummaryItem(title: "Leave Taken", value: "2 days", iconName: "event_note"),
  ];

  IconData getIcon(String name) {
    switch (name) {
      case "calendar_today":
        return Icons.calendar_today;
      case "access_time":
        return Icons.access_time;
      case "av_timer":
        return Icons.av_timer;
      case "bar_chart":
        return Icons.bar_chart;
      case "person":
        return Icons.person;
      case "event_note":
        return Icons.event_note;
      default:
        return Icons.info;
    }
  }

  Widget buildSummaryCard(SummaryItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(getIcon(item.iconName), color: Colors.teal, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              item.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
