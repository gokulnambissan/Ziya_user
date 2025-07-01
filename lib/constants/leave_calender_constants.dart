import 'package:ziya_user/constants/app_strings.dart';

enum LeaveStatus { approved, pending, rejected, upcoming }

extension LeaveStatusLabel on LeaveStatus {
  String get label => switch (this) {
        LeaveStatus.approved => AppStrings.approved,
        LeaveStatus.pending  => AppStrings.pending,
        LeaveStatus.rejected => AppStrings.rejected,
        LeaveStatus.upcoming => AppStrings.upcoming,
      };
}

const Map<String, LeaveStatus> kDemoLeaveStatus = {
  '2025-06-03': LeaveStatus.approved,
  '2025-06-12': LeaveStatus.approved,
  '2025-06-16': LeaveStatus.rejected,
  '2025-06-17': LeaveStatus.rejected,
  '2025-06-20': LeaveStatus.pending,
  '2025-06-25': LeaveStatus.upcoming,
};
