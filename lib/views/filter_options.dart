import 'package:flutter/material.dart';
import 'package:ziya_user/view_models/filter_options_viewmodel.dart';
import '../constants/app_strings.dart';

class FilterOptions extends StatefulWidget {
  final FilterOptionsViewModel viewModel;

  const FilterOptions({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              "Sort by : ",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 16),

            _buildCustomRadio(
              isSelected: true, 
              onTap: () {
                setState(() {
                  widget.viewModel.onChanged(true);
                });
              },
            ),
            const SizedBox(width: 6),
            const Text(AppStrings.deadline),

            const SizedBox(width: 35),

            _buildCustomRadio(
              isSelected: true,
              onTap: () {
                setState(() {
                  widget.viewModel.onChanged(false);
                });
              },
            ),
            const SizedBox(width: 4),
            const Text(AppStrings.project),
          ],
        ),
        const Icon(Icons.format_list_bulleted_rounded),
      ],
    );
  }

  Widget _buildCustomRadio({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:14,
        height: 14,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 218, 218, 218), // Light grey background
        ),
        child: Center(
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.black : Colors.transparent, // Always black for demo
            ),
          ),
        ),
      ),
    );
  }
}
