import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class PunchDialogs {
  static void showUnifiedPunchDialog({
    required BuildContext context,
    required bool isPunchIn,
    required Function(String) onSelected,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        String? selectedOption;
        final options = isPunchIn
            ? ["On Site", "Work From Home"]
            : ["Update Task", "Punch Out"];

        return StatefulBuilder(builder: (context, setStateSB) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            title: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  isPunchIn ? "Select Punch In Type" : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isPunchIn) ...[
                  const Icon(Icons.warning_amber_rounded,
                      size: 60, color: AppColors.orange),
                  const SizedBox(height: 12),
                  const Text(
                    "Do you really want to checkout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
                if (isPunchIn) ...[
                  const Text(
                    "Are you working from home or on site today?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
                Row(
                  children: options.map((type) {
                    final isSelected = selectedOption == type;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setStateSB(() => selectedOption = type);
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              Navigator.pop(context);
                              onSelected(type);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isSelected ? AppColors.blue : AppColors.white,
                            foregroundColor:
                                isSelected ? AppColors.white : AppColors.black,
                            elevation: 4,
                            // ignore: deprecated_member_use
                            shadowColor: AppColors.grey.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            minimumSize: const Size(0, 50),
                          ),
                          child: Text(
                            type,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
