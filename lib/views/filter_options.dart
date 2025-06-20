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
            Radio<bool>(
              value: true,
              groupValue: widget.viewModel.isDeadlineSelected,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    widget.viewModel.onChanged(value);
                  });
                }
              },
            ),
            const Text(AppStrings.deadline),
            const SizedBox(width: 10),
            Radio<bool>(
              value: true,
              groupValue: widget.viewModel.isDeadlineSelected,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    widget.viewModel.onChanged(value);
                  });
                }
              },
            ),
            const Text(AppStrings.project),
          ],
        ),
        const Icon(Icons.filter_list),
      ],
    );
  }
}
