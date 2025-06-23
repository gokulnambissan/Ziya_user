import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class PunchViewModel {
  bool checkedIn = false;
  String checkInStatus = AppStrings.checkInPrompt;
  Color statusColor = AppColors.red;
  String? checkOutTimeMessage;

  void punchIn(Function updateUI) {
    checkedIn = true;
    checkInStatus = "You're checked in at ${DateFormat.jm().format(DateTime.now())}!";
    statusColor = AppColors.green;
    checkOutTimeMessage = null;
    updateUI();
  }

  void punchOut(Function updateUI) {
    checkedIn = false;
    checkInStatus = AppStrings.checkInPrompt;
    statusColor = AppColors.red;
    checkOutTimeMessage = "Checked out at ${DateFormat.jm().format(DateTime.now())}";
    updateUI();
  }
}
