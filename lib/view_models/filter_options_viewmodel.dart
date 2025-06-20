import 'package:flutter/material.dart';

class FilterOptionsViewModel {
  final bool isDeadlineSelected;
  final ValueChanged<bool> onChanged;

  FilterOptionsViewModel({
    required this.isDeadlineSelected,
    required this.onChanged,
  });
}