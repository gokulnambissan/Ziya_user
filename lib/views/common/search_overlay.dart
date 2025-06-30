import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class SearchOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const SearchOverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,            
      color: Colors.black.withOpacity(0.5), 
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onClose,
                      child: Container(
                        margin: const EdgeInsets.only(left: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        '05 May 2025',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.send, color: AppColors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search History',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Align(alignment: Alignment.centerLeft, child: Text('Sick Leave ')),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Align(alignment: Alignment.centerLeft, child: Text('23 May 2025  ')),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Align(alignment: Alignment.centerLeft, child: Text('Casual Leaves  ')),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onClose,
              child: Container(color: const Color.fromARGB(0, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}


void showSearchOverlay(BuildContext context) {
  late OverlayEntry entry;
  final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: Navigator.of(context),
  );
  final Animation<Offset> offsetAnimation = Tween(
    begin: const Offset(0, -0.05),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

  entry = OverlayEntry(
    builder: (_) {
      return FadeTransition(
        opacity: controller,
        child: SlideTransition(
          position: offsetAnimation,
          child: SearchOverlay(
            onClose: () {
              controller.reverse().then((_) {
                entry.remove();
                controller.dispose();
              });
            },
          ),
        ),
      );
    },
  );

  Overlay.of(context, rootOverlay: true).insert(entry);
  controller.forward();
}


