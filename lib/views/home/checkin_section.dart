import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CheckInSection extends StatelessWidget {
  final String checkInStatus;
  final Color statusColor;
  final bool checkedIn;
  final String? checkOutTimeMessage;
  final String? extraTimeInfo;
  final String? locationInfo;
  final VoidCallback onPunchInTap;
  final VoidCallback onPunchOutTap;

  const CheckInSection({
    Key? key,
    required this.checkInStatus,
    required this.statusColor,
    required this.checkedIn,
    required this.checkOutTimeMessage,
    required this.onPunchInTap,
    required this.onPunchOutTap,
    this.extraTimeInfo,
    this.locationInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.grey, blurRadius: .5, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                checkInStatus,
                style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              if (extraTimeInfo != null)
                Row(
                  children: [
                    const Icon(Icons.access_time, color: AppColors.orange, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      extraTimeInfo!,
                      style: const TextStyle(
                        color: AppColors.orange,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              if (locationInfo != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.red, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        locationInfo!,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              if (checkOutTimeMessage != null)
                Text(
                  checkOutTimeMessage!,
                  style: const TextStyle(color: AppColors.black, fontSize: 12),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: checkedIn ? null : onPunchInTap,
                icon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  child: Image.asset('assets/login.png', height: 14, width: 14),
                ),
                label: const Text("Punch In",
                style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.grey,
                  disabledForegroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding :EdgeInsets.only(left: 18,right: 18),
                ),
              ),
              const SizedBox(width: 30),
              ElevatedButton.icon(
                onPressed: checkedIn ? onPunchOutTap : null,
                icon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  child: Image.asset('assets/logout.png', height: 14, width: 14),
                ),
                label: const Text("Punch Out",
                style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.grey,
                  disabledForegroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding :EdgeInsets.only(left: 18,right: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
