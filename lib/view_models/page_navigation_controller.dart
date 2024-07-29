import 'package:flutter/material.dart';

class PageNavigationController extends ChangeNotifier {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  int get currentPageIndex => _currentPageIndex;
  PageController get pageController => _pageController;
  bool _pageIndexFromTab = false;
  bool get pageIndexFromTab => _pageIndexFromTab;
  void setPageIndexFromTab(int index) {
    _pageIndexFromTab = true;
    setPageIndex(index);
  }

  void setPageIndex(int index) {
    _currentPageIndex = index;
    _pageController.animateToPage(
      _currentPageIndex,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );

    notifyListeners();
  }
}
