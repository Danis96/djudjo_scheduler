import 'package:djudjo_scheduler/widgets/drawer_list_item/custom_drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routing/routes.dart';
import '../../theme/color_helper.dart';

class DrawerHelper {
  List<DrawerListItem> drawerListItems(BuildContext context) {
    return <DrawerListItem>[
      DrawerListItem(
        title: 'Home',
        routeName: Home,
        iconData: Icons.home,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: 'Profile',
        routeName: Home,
        iconData: Icons.person,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: 'Settings',
        iconData: Icons.settings,
        routeName: Home,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
    ];
  }
}
