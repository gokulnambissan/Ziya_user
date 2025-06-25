
// app_decorations.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  static const BoxDecoration headerDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.blue, AppColors.green],
      stops: [0.0, 0.6],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
}
