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
              borderRadius: BorderRadius.circular(16),
            ),
            title: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  isPunchIn ? "Select Punch In Type" : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
                      size: 50, color: AppColors.orange),
                  const SizedBox(height: 10),
                  const Text(
                    "Do you really want to checkout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (isPunchIn) ...[
                  const Text(
                    "Are you working from home or on site today?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final type = entry.value;
                    final isSelected = selectedOption == type;

                    return Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setStateSB(() => selectedOption = type);
                            Future.delayed(const Duration(milliseconds: 200), () {
                              Navigator.pop(context);
                              onSelected(type);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? AppColors.blue
                                : AppColors.white,
                            foregroundColor: isSelected
                                ? AppColors.white
                                : AppColors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.blue
                                    : AppColors.grey,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: Text(type),
                        ),
                        if (index < options.length - 1)
                          const SizedBox(width: 16),
                      ],
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
