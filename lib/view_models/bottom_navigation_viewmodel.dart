// lib/view_models/bottom_navigation_viewmodel.dart
import 'dart:ui';

class BottomNavigationViewModel {
  int currentIndex;

  BottomNavigationViewModel({this.currentIndex = 0});

  void setIndex(int index, VoidCallback onUpdate) {
    currentIndex = index;
    onUpdate();
  }
}
