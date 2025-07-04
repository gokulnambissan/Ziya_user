import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BoxInfo extends StatelessWidget {
  final String label;
  final String value;

  const BoxInfo(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.lightGrey)),
          const SizedBox(width: 4),
          const Text(":  ",
              style: TextStyle(fontSize: 11, color: AppColors.lightGrey)),
          const SizedBox(width: 4),
          Text(value,
              style:
              const TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color: AppColors.lightGrey)),
        ],
      ),
    );
  }
}

class PayslipInfo extends StatelessWidget {
  final String label;
  final String value;

  const PayslipInfo(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    color: AppColors.lightGrey, fontSize: 9)),
          ),
          const Text(":  "),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 9)),
          ),
        ],
      ),
    );
  }
}


Widget buildHistory(
    String month, String pay, String status, String action,
    {bool isHeader = false, VoidCallback? onDownload}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(month,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
            child: Text(pay,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
            child: Text(status,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
          child: isHeader
              ? Text(action,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
              : GestureDetector(
            onTap: onDownload,
            child: Text(action,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                    decoration: TextDecoration.underline)),
          ),
        ),
      ],
),
);
}