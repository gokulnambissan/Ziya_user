import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class InlineSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final String query;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onSubmit;
  final VoidCallback onClose;

  const InlineSearchBar({
    super.key,
    required this.query,
    required this.onQueryChanged,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: AppColors.white,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: onClose,
            ),
            const SizedBox(width: 4),
            const Icon(Icons.search, color: AppColors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: onQueryChanged,
                onSubmitted: (_) => onSubmit(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppColors.green, size: 30),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
