import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import '../view/bottom_navigation_bar/bottom_navigation_page.dart';
import '../view/home_page/home_page.dart';

class BottomNavigationHelper {
  List<CustomBottomNavigationItem> bottomNavigationItems() => <CustomBottomNavigationItem>[
        CustomBottomNavigationItem(title: 'Home', icon: Icons.home, page: const Homepage()),
        CustomBottomNavigationItem(title: 'Schedule', icon: Icons.format_list_bulleted_rounded, page: const Homepage()),
      ];

  void selectNavigationItem(BuildContext context, int item) {
    final BottomNavigationBar navigationBar = bottomWidgetKey.currentWidget as BottomNavigationBar;
    navigationBar.onTap!(item);
  }
}
