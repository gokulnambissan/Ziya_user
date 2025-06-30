import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';

class SearchOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final Offset anchor;
  final Size anchorSize;

  const SearchOverlay({
    super.key,
    required this.onClose,
    required this.anchor,
    required this.anchorSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.black.withOpacity(0.45),
      child: Stack(
        children: [
          GestureDetector(
              onTap: onClose, child: Container(color: Colors.transparent)),
          Positioned(
            left: 1,
            right: 1,                       
            top: anchor.dy + anchorSize.height + 4,
            child: _panel(),
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return Material(
      borderRadius: BorderRadius.circular(6),
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, size: 20),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(8),
                  child:
                      const Icon(Icons.send, color: AppColors.white, size: 20),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Search History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          ...const [
            'Sick Leave',
            '23 May 2025',
            'Casual Leaves',
          ].map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Align(alignment: Alignment.centerLeft, child: Text(t)),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

void showSearchOverlay(
  BuildContext context, {
  required GlobalKey searchBarKey,
  required VoidCallback afterClosed,
}) {
  final renderBox =
      searchBarKey.currentContext!.findRenderObject() as RenderBox;
  final anchorSize = renderBox.size;
  final anchorOffset = renderBox.localToGlobal(Offset.zero);

  late OverlayEntry entry;
  final ctrl = AnimationController(
    vsync: Navigator.of(context),
    duration: const Duration(milliseconds: 250),
  );
  final slide =
      Tween(begin: const Offset(0, -0.05), end: Offset.zero).animate(ctrl);

  entry = OverlayEntry(
    builder: (_) => FadeTransition(
      opacity: ctrl,
      child: SlideTransition(
        position: slide,
        child: SearchOverlay(
          anchor: anchorOffset,
          anchorSize: anchorSize,
          onClose: () {
            ctrl.reverse().then((_) {
              entry.remove();
              ctrl.dispose();
              afterClosed(); 
            });
          },
        ),
      ),
    ),
  );

  Overlay.of(context, rootOverlay: true).insert(entry);
  ctrl.forward();
}
