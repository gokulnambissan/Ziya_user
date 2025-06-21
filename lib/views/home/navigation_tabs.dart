import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = screenWidth / 3; // show exactly 3 tabs

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pageTitles.length,
        itemBuilder: (context, index) {
          final isSelected = index == currentPage;
          return SizedBox(
            width: tabWidth,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton.icon(
                onPressed: () => onTabSelected(index),
                icon: Icon(
                  pageIcons[index],
                  size: 18,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
                label: Text(
                  pageTitles[index],
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? AppColors.blue : AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: isSelected ? 2 : 1,
                  side: BorderSide(color: AppColors.grey),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
