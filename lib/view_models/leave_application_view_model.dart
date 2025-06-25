import 'package:flutter/material.dart';

class LeaveApplicationViewModel extends ChangeNotifier {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController attachmentController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  String? selectedLeaveType;

  final List<String> leaveTypes = [
    'Sick Leave',
    'Casual Leave',
    'Earned Leave',
    'Maternity Leave',
    'Paternity Leave',
    'Work From Home',
  ];

  void pickDate(BuildContext context, bool isFromDate, Function setState) async {
    final DateTime today = DateTime.now();
    final DateTime initial =
        isFromDate ? (fromDate ?? today) : (toDate ?? (fromDate ?? today));

    final DateTime first =
        isFromDate ? today : (fromDate != null ? fromDate! : today);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
          if (toDate != null && toDate!.isBefore(fromDate!)) {
            toDate = null;
          }
        } else {
          toDate = picked;
        }
      });
    }
  }

  void disposeControllers() {
    reasonController.dispose();
    attachmentController.dispose();
  }
}
