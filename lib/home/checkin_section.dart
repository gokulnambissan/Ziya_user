import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          /// Main status message (Check-In/Out status)
          Text(
            checkInStatus,
            style: TextStyle(color: statusColor, fontSize: 16),
          ),

          const SizedBox(height: 8),

          /// Fixed-height message box for the checkout message
          SizedBox(
            height: 20, // Reserve space to prevent layout shift
            child: checkOutTimeMessage != null
                ? Text(
                    checkOutTimeMessage!,
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  )
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 12),

          /// Buttons for Check-In and Check-Out
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onCheckIn,
                icon: const Icon(Icons.login),
                label: const Text("Check In"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: checkedIn ? Colors.blue : Colors.grey[300],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: onCheckOut,
                icon: const Icon(Icons.logout),
                label: const Text("Check Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !checkedIn ? Colors.blue : Colors.grey[300],
                  foregroundColor: Colors.white,
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
