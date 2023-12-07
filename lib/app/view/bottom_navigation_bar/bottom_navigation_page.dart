import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import '../../utils/bottom_navigation_helper.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({this.initial = 0});

  final int initial;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

final GlobalKey bottomWidgetKey = GlobalKey<State<BottomNavigationBar>>();

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final BottomNavigationHelper _navigationHelper = BottomNavigationHelper();
  NotchBottomBarController notchBottomBarController = NotchBottomBarController();

  @override
  Widget build(BuildContext context) {
    return
    CustomBottomNavigationPage(
      selectedItemColor: ColorHelper.black.color,
      unSelectedItemColor: ColorHelper.black.color.withOpacity(0.4),
      items: _navigationHelper.bottomNavigationItems(),
      showTitle: false,
      showUnselectedLabel: true,
      showTitleFromSide: false,
      bottomNavigationBarType: BottomNavigationBarType.fixed,
      backgroundColor: ColorHelper.white.color,
      innerPadding: 10,
      elevation: 0,
      initialSelection: widget.initial,
    );
  }
}
