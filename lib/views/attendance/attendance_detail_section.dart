// attendance_detail_section.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/models/attendance_record.dart';

class AttendanceDetailSection extends StatelessWidget {
  const AttendanceDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recDate = DateTime(2025, 6, 18);
    const workMode = 'Office';
    const verify = 'Selfie';
    const notes = 'Worked on UI Bug Fixing';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('MMMM d, yyyy').format(recDate),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Status',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              _statusPill(DayType.present),
            ],
          ),
          const SizedBox(height: 8),
          const _DottedDivider(),
          const SizedBox(height: 16),
          Row(
            children: [
              _timeTile(
                label: 'Check‑in',
                time: DateTime(recDate.year, recDate.month, recDate.day, 9, 30),
                isCheckIn: true,
              ),
              const Expanded(
                child: Icon(Icons.arrow_forward,
                    size: 22, color: AppColors.grey),
              ),
              _timeTile(
                label: 'Check‑out',
                time: DateTime(recDate.year, recDate.month, recDate.day, 18, 0),
                isCheckIn: false,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _infoTile(
                  title: 'Work Mode',
                  value: workMode,
                  chipColor: AppColors.blue,
                  showLeftAccent: true,
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: _infoTile(
                  title: 'Verification',
                  value: verify,
                  chipColor: AppColors.orange,
                  showLeftAccent: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _infoTile(
            leadingIcon: Icons.location_pin,
            title: 'Location',
            value: 'Lat: 13.05, Long: 80.24',
            height: 80,
          ),
          const SizedBox(height: 16),
          _infoTile(
            leadingIcon: Icons.notes,
            title: 'Notes',
            value: notes,
            height: 80,
          ),
        ],
      ),
    );
  }
}

Widget _timeTile({
  required String label,
  DateTime? time,
  required bool isCheckIn,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
              isCheckIn
                  ? Icons.alarm_on_outlined
                  : Icons.alarm_off_outlined,
              size: 18,
              color: AppColors.green),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.black)),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        time != null ? DateFormat('hh:mm a').format(time) : '--',
        style: const TextStyle(fontSize: 14, color: AppColors.green),
      ),
    ],
  );
}

Widget _infoTile({
  IconData? leadingIcon,
  required String title,
  required String value,
  double height = 90,
  Color? chipColor,
  bool showLeftAccent = false,
}) {
  final hasChip = chipColor != null;

  return Container(
    height: height,
    margin: EdgeInsets.only(top: leadingIcon == null ? 0 : 2),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: AppColors.grey,
          blurRadius: 0.5,
          offset: Offset(0, 0),
        ),
      ],
      borderRadius: BorderRadius.circular(8),
      border: showLeftAccent
          ? const Border(left: BorderSide(color: AppColors.blue, width: 3))
          : null,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (leadingIcon != null)
              Icon(leadingIcon, size: 18, color: AppColors.red),
            if (leadingIcon != null) const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        hasChip
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: chipColor!.withOpacity(.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(value,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: chipColor)),
              )
            : Text(value,
                style: const TextStyle(fontSize: 14, color: AppColors.black)),
      ],
    ),
  );
}

Widget _statusPill(DayType type) {
  Color bg;
  String txt;
  switch (type) {
    case DayType.present:
      bg = AppColors.green;
      txt = 'Present';
      break;
    case DayType.absent:
      bg = AppColors.red;
      txt = 'Absent';
      break;
    case DayType.leave:
      bg = AppColors.orange;
      txt = 'Leave';
      break;
    case DayType.late:
      bg = AppColors.blue;
      txt = 'Late';
      break;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: bg.withOpacity(.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(txt,
        style: TextStyle(color: bg, fontWeight: FontWeight.w600)),
  );
}

class _DottedDivider extends StatelessWidget {
  const _DottedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        const dot = 4.0, gap = 4.0;
        final count = (constraints.maxWidth / (dot + gap)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => const SizedBox(
              width: dot,
              height: 1,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.grey)),
            ),
          ),
        );
      },
    );
  }
}
