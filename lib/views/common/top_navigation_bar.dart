import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/notification/notification_page_body.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearchTap;
  final String searchHint;
  final GlobalKey? searchBarKey;

  const TopNavigationBar({
    super.key,
    required this.onSearchTap,
    this.searchHint = 'Search',
    this.searchBarKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.grey),
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
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                key: searchBarKey,
                onTap: onSearchTap,
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 20, color: AppColors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          searchHint,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ✅ Wrap notification icon with GestureDetector with slide transition
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const NotificationsPageBody(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // Slide from right
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
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
            ),

            const SizedBox(width: 12),

            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/profile_pic.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
