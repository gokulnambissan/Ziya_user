import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class PunchViewModel {
  bool checkedIn = false;
  String checkInStatus = AppStrings.checkInPrompt;
  Color statusColor = AppColors.red;
  String? checkOutTimeMessage;

  // Store last punch-in mode locally (Work From Home or On Site)
  String? _lastPunchInMode;

  // UI-specific fields
  String? extraTimeInfo;   // e.g., June 24, 2025 10:35 AM
  String? locationInfo;    // e.g., 192.168.0.101 (Remote)

  /// Punch in logic for demo
  Future<void> punchIn(Function updateUI, String mode) async {
    final now = DateTime.now();

    checkedIn = true;
    _lastPunchInMode = mode;

    checkInStatus = "You're Punched in at ${DateFormat.jm().format(now)}!";
    statusColor = AppColors.green;
    checkOutTimeMessage = null;

    // Set additional info
    extraTimeInfo = DateFormat.yMMMMd().add_jm().format(now);

    // Show location info only if working from home
    if (mode == "Work From Home") {
      locationInfo = "192.168.0.101 (Remote)";
    } else {
      locationInfo = null;
    }

    updateUI();
  }

  /// Punch out logic for demo
  Future<void> punchOut(Function updateUI) async {
    final now = DateTime.now();

    checkedIn = false;
    checkInStatus = AppStrings.checkInPrompt;
    statusColor = AppColors.red;
    checkOutTimeMessage = "Punched out at ${DateFormat.jm().format(now)}";

    // Clear extra display info
    extraTimeInfo = null;
    locationInfo = null;

    updateUI();
  }

  /// Get last punch-in mode for conditional punch-out
  Future<String?> getLastPunchInMode() async {
    return _lastPunchInMode;
  }
}
