import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final bool isDeadlineSelected;
  final ValueChanged<bool> onChanged;

  const FilterOptions({
    Key? key,
    required this.isDeadlineSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isDeadlineSelected,
              onChanged: (bool? value) {
                if (value != null) onChanged(value);
              },
            ),
            const Text("Deadline"),
            const SizedBox(width: 10),
            Radio<bool>(
              value: false,
              groupValue: isDeadlineSelected,
              onChanged: (bool? value) {
                if (value != null) onChanged(value);
              },
            ),
            const Text("Project"),
          ],
        ),
        const Icon(Icons.filter_list),
      ],
    );
  }
}
