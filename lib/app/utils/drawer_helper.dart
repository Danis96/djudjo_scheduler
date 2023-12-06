import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:djudjo_scheduler/widgets/drawer_list_item/custom_drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routing/routes.dart';
import '../../theme/color_helper.dart';

class DrawerHelper {
  List<DrawerListItem> drawerListItems(BuildContext context) {
    return <DrawerListItem>[
      DrawerListItem(
        title: Language.dr_item_home,
        routeName: Home,
        iconData: Icons.home,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: Language.dr_item_profile,
        routeName: Home,
        iconData: Icons.person,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: Language.dr_item_up,
        routeName: Notifications,
        arguments: context.read<AppointmentProvider>(),
        iconData: Icons.schedule,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: Language.dr_item_settings,
        iconData: Icons.settings,
        routeName: Home,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
    ];
  }
}
