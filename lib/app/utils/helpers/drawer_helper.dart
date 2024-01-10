import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:djudjo_scheduler/app/providers/stupidity_provider/stupidity_provider.dart';
import 'package:djudjo_scheduler/app/utils/language/language_strings.dart';
import 'package:djudjo_scheduler/routing/route_arguments.dart';
import 'package:djudjo_scheduler/widgets/drawer_list_item/custom_drawer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';

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
        title: Language.dr_item_new,
        routeName: NewAppointment,
        arguments: context.read<AppointmentProvider>(),
        iconData: Icons.assistant,
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
        title: Language.dr_item_favorite,
        routeName: Favorites,
        arguments: context.read<AppointmentProvider>(),
        iconData: Icons.favorite_border,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: Language.dr_item_history,
        routeName: History,
        arguments: context.read<AppointmentProvider>(),
        iconData: Icons.manage_history,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
      DrawerListItem(
        title: Language.dr_item_settings,
        iconData: Icons.settings,
        routeName: Settings,
        arguments:
            SettingsPageArguments(context.read<AppointmentProvider>(), context.read<LoginProvider>(), context.read<StupidityProvider>()),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerRed.color),
      ),
    ];
  }
}
