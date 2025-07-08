import 'package:flutter/material.dart';
import 'package:ziya_user/views/notification/notification_page_body.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';

class HeaderSection extends StatelessWidget {
  final String userName;

  const HeaderSection({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 55,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                // 👉🏻 LEFT side gradient with name and image
                Expanded(
                  flex: 14,
                  child: OverflowBox(
                    maxHeight: 55,
                    minHeight: 50,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 55,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.blue, AppColors.green],
                          stops: [0.0, 0.6],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/profile_pic.jpg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  AppStrings.developerTitle,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    height: 1.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 👉🏻 RIGHT side notification icon
                Expanded(
                  flex: 5,
                  child: Container(
                    height: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const NotificationsPageBody(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0); // From right
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
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 👉🏻 Center logo
            Positioned(
              right: MediaQuery.of(context).size.width * 0.26 - 25,
              top: 10,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    'assets/logo.jpg',
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
