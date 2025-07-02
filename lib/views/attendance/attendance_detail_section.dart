// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ziya_user/view_models/attendance_view_model.dart';
import '../../constants/app_colors.dart';
import '../../models/attendance_record.dart';

class AttendanceDetailSection extends StatelessWidget {
  const AttendanceDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = AttendanceViewModel();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('MMMM d, yyyy').format(vm.recDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Status',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              _statusPill(vm.status),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: CustomPaint(
              painter: DottedLinePainter(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _timeTile('Check‑in', vm.checkIn, true),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              _timeTile('Check‑out', vm.checkOut, false),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _infoContainer(
                  'Work Mode',
                  vm.workMode,
                  AppColors.blue,
                ),
              ),
              const SizedBox(width: 90),
              Expanded(
                child: _infoContainer(
                  'Verification',
                  vm.verification,
                  AppColors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _boxTile(Icons.person_pin_circle_outlined, 'Location',
              'Lat: ${vm.lat}, Long: ${vm.lon}'),
          const SizedBox(height: 8),
          _boxTile(Icons.sticky_note_2_outlined, 'Notes', vm.notes),
        ],
      ),
    );
  }

  Widget _statusPill(DayType type) {
    late Color color;
    late String label;
    switch (type) {
      case DayType.present:
        color = AppColors.green;
        label = 'Present';
        break;
      case DayType.absent:
        color = AppColors.red;
        label = 'Absent';
        break;
      case DayType.leave:
        color = AppColors.orange;
        label = 'Leave';
        break;
      case DayType.late:
        color = AppColors.blue;
        label = 'Late';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }

  Widget _timeTile(String label, TimeOfDay time, bool isCheckIn) {
    final formatted = DateFormat('hh:mm a').format(
      DateTime(0, 0, 0, time.hour, time.minute),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isCheckIn ? Icons.alarm_on_outlined : Icons.alarm_off_outlined,
              size: 18,
              color: AppColors.green,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          formatted,
          style: const TextStyle(
            color: AppColors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _infoContainer(String title, String value, Color chipColor) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(
            color: AppColors.blue,
            width: 3,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: chipColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: chipColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxTile(IconData icon, String title, String value) {
    final isNote = icon == Icons.sticky_note_2_outlined;

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: isNote ? AppColors.black : AppColors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;

    final paint = Paint()
      ..color = AppColors.grey
      ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
