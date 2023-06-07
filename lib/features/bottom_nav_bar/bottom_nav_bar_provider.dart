import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
}
