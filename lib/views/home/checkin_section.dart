import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_colors.dart';

class CheckInSection extends StatelessWidget {
  final String checkInStatus;
  final Color statusColor;
  final bool checkedIn;
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;
  final String? checkOutTimeMessage;

  const CheckInSection({
    Key? key,
    required this.checkInStatus,
    required this.statusColor,
    required this.checkedIn,
    required this.onCheckIn,
    required this.onCheckOut,
    this.checkOutTimeMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 150, 
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Column(
            children: [
              Text(checkInStatus, style: TextStyle(color: statusColor, fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                checkOutTimeMessage ?? '', 
                style: const TextStyle(color: AppColors.black, fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onCheckIn,
                icon: const Icon(Icons.login),
                label: const Text(AppStrings.checkIn),
                style: ElevatedButton.styleFrom(
                  backgroundColor: checkedIn ? AppColors.blue : AppColors.grey,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: onCheckOut,
                icon: const Icon(Icons.logout),
                label: const Text(AppStrings.checkOut),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !checkedIn ? AppColors.blue : AppColors.grey,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
