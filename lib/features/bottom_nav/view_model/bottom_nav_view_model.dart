import 'package:flutter/foundation.dart';

class BottomNavViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  final Set<int> _visitedTabs = {0};

  int get selectedIndex => _selectedIndex;
  bool hasVisited(int index) => _visitedTabs.contains(index);

  void selectTab(int index) {
    if (index < 0 || index > 2 || index == _selectedIndex) return;
    _selectedIndex = index;
    _visitedTabs.add(index);
    notifyListeners();
  }
}
