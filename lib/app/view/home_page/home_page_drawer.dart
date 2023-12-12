import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/drawer/custom_drawer.dart';
import '../../utils/helpers/dialog_helper.dart';
import '../../utils/helpers/drawer_helper.dart';
import '../../utils/language/language_strings.dart';

Widget buildDrawer(BuildContext context) {
  final DrawerHelper _drawerHelper = DrawerHelper();

  return CustomDrawer(
    widgetKey: const Key('home_page_drawer_key'),
    actionKey: const Key('drawer_action_home_page_key'),
    onDrawerItemPressed: (String value) {},
    onDrawerOpened: (String value) {},
    wrapWithMaterial: true,
    headerHeight: 200,
    backgroundColor: ColorHelper.white.color,
    logoutTitle: Language.hd_logout_title,
    onLogoutPress: () => showLogoutDialog(context),
    listItems: _drawerHelper.drawerListItems(context),
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.black.color),
    logoutStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: ColorHelper.black.color),
    customHeader: Image.asset(Assets.assetsDrBack, width: double.infinity, fit: BoxFit.fill),
  );
}
