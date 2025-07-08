import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/models/notification_model.dart';
import 'package:ziya_user/view_models/notification_view_model.dart';

class NotificationsPageBody extends StatefulWidget {
  const NotificationsPageBody({super.key});

  @override
  State<NotificationsPageBody> createState() => _NotificationsPageBodyState();
}

class _NotificationsPageBodyState extends State<NotificationsPageBody> {
  final NotificationsViewModel viewModel = NotificationsViewModel();

 @override
Widget build(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.black, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: viewModel.notifications.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 18, // match card title
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        decoration: TextDecoration.none, 
                      ),
                    ),
                  ),
                );
              }

              final notification = viewModel.notifications[index - 1];
              return _buildNotificationCard(notification);
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _buildNotificationCard(NotificationModel notification) {
    IconData icon;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.missedPunch:
        icon = Icons.close;
        iconColor = AppColors.red;
        break;
      case NotificationType.lateAttendance:
        icon = Icons.alarm;
        iconColor = AppColors.orange;
        break;
      case NotificationType.dailySummary:
        icon = Icons.summarize;
        iconColor = AppColors.blue;
        break;
      case NotificationType.leaveApproval:
        icon = Icons.check_circle;
        iconColor = AppColors.green;
        break;
      case NotificationType.leaveRejection:
        icon = Icons.do_not_disturb_on_rounded;
        iconColor = AppColors.red;
        break;
      case NotificationType.shiftUpdate:
        icon = Icons.shuffle_on_sharp;
        iconColor = AppColors.lightBlue;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.black,
                ),
                children: [
                  TextSpan(
                    text: "${notification.title}\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: iconColor,
                    ),
                  ),
                  TextSpan(
                    text: notification.message,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
