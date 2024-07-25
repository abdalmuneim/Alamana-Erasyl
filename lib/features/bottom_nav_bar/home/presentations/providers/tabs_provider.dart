import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:flutter/material.dart';

class TabsProvider extends ChangeNotifier {
  final context = NavigationService.context;
  late TabController _tabController;

  void setTabController(TickerProvider tickerProvider) {
    _tabController = TabController(length: 2, vsync: tickerProvider);
  }

  TabController get tabController => _tabController;

  int get currentIndex => _tabController.index;

  void setCurrentIndex(int index) {
    _tabController.animateTo(index);
    notifyListeners();
  }
}
