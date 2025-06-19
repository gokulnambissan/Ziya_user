import 'package:flutter/material.dart';

class NavigationTabs extends StatelessWidget {
  final int currentPage;
  final List<String> pageTitles;
  final List<IconData> pageIcons;
  final Function(int) onTabSelected;

  const NavigationTabs({
    Key? key,
    required this.currentPage,
    required this.pageTitles,
    required this.pageIcons,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pageTitles.length,
        itemBuilder: (context, index) {
          final isSelected = index == currentPage;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              onPressed: () => onTabSelected(index),
              icon: Icon(pageIcons[index],
                  size: 18, color: isSelected ? Colors.white : Colors.black),
              label: Text(
                pageTitles[index],
                style: TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: isSelected ? 2 : 1,
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          );
        },
      ),
    );
  }
}
