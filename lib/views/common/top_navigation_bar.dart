import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavigationBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            //color: Color(0xFFE0E0E0), 
            color: AppColors.grey,
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0, // No shadow
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.03),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 14),
                    prefixIcon: Icon(Icons.search, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.notifications, color: AppColors.blue),
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
