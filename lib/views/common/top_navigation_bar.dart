import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearchTap;

  const TopNavigationBar({super.key, required this.onSearchTap});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 45,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.search, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Search',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: AppColors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/profile_pic.jpg'),
              radius: 18,
            ),
          ],
        ),
      ),
    );
  }
}
