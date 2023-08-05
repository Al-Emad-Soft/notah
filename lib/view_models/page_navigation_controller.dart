import 'package:flutter/material.dart';

class PageNavigationController extends ChangeNotifier {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  int get currentPageIndex => _currentPageIndex;
  PageController get pageController => _pageController;

  void setPageIndex(int index) {
    _currentPageIndex = index;

    _pageController.animateToPage(
      _currentPageIndex,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
    );
    notifyListeners();
  }
}
