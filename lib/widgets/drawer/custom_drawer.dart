import 'package:djudjo_scheduler/app/providers/stupidity_provider/stupidity_provider.dart';
import 'package:djudjo_scheduler/app/utils/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/color_helper.dart';
import '../drawer_list_item/custom_drawer_list_item.dart';
import '../switches/switch_with_title_description.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(
      {this.backgroundColor,
      this.headerHeight = 80,
      this.headerCenterWidget,
      this.actionIcon,
      this.actionIconColor,
      this.onActionIconPress,
      this.actionLinkClicked,
      this.listItems,
      this.widgetKey,
      this.actionKey,
      this.logoutTitle,
      this.onLogoutPress,
      this.onDrawerOpened,
      this.onDrawerItemPressed,
      this.labelStyle,
      this.customHeader,
      this.logoutStyle,
      this.logoutTitleColor,
      this.headerCenter = true,
      this.headerMainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.wrapWithMaterial = false,
      this.appVersion,
      this.listItemBottomPadding = 12.0,
      this.appVersionStyle = const TextStyle(
        color: Color.fromRGBO(57, 70, 82, 1),
        fontSize: 14,
      ),
      this.elevation});

  final Color? backgroundColor;
  final double headerHeight;
  final Widget? headerCenterWidget;
  final IconData? actionIcon;
  final Color? actionIconColor;
  final Color? logoutTitleColor;
  final Function? onActionIconPress;
  final List<DrawerListItem>? listItems;
  final Key? widgetKey;
  final Key? actionKey;

  // if this is null then it will not be shown on drawer widget
  final String? logoutTitle;
  final Function? onLogoutPress;
  final Function? actionLinkClicked;
  final Function(String)? onDrawerOpened;
  final Function(String)? onDrawerItemPressed;
  final TextStyle? labelStyle;
  final TextStyle? logoutStyle;
  final Widget? customHeader;
  final bool headerCenter;
  final MainAxisAlignment headerMainAxisAlignment;
  final bool wrapWithMaterial;
  final String? appVersion;
  final TextStyle appVersionStyle;
  final double listItemBottomPadding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: elevation,
      key: widgetKey,
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: headerHeight,
              child: customHeader ??
                  Row(
                    mainAxisAlignment: headerMainAxisAlignment,
                    children: <Widget>[
                      if (headerCenter) Container(width: 50),
                      headerCenterWidget!,
                      Container(
                        margin: const EdgeInsets.only(right: 16, top: 5),
                        child: GestureDetector(
                            key: actionKey, onTap: () => onActionIconPress!(), child: Icon(actionIcon!, color: actionIconColor)),
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: listItems!.mapIndex((DrawerListItem item, int index) {
                    return _tapItem(
                        wrapWithMaterial,
                        DrawerListItem(
                          widgetKey: Key('${item.title}_$index'),
                          title: item.title,
                          textStyle: labelStyle,
                          iconData: item.iconData,
                          margin: EdgeInsets.only(left: 15, top: 12, bottom: listItemBottomPadding),
                        ), () {
                      if (item.isLink!) {
                        actionLinkClicked!();
                      } else {
                        if (onDrawerItemPressed != null) {
                          onDrawerItemPressed!(item.routeName!);
                        }
                        Navigator.of(context).pushNamed(item.routeName!, arguments: item.arguments).then((_) {
                          if (onDrawerOpened != null) {
                            onDrawerOpened!(item.routeName!);
                          }
                        });
                      }
                    }, backgroundColor);
                  }).toList()),
            ),
           _buildStupiditySwitch(context),
            const Divider(),
            if (logoutTitle != null)
              _buildLogout(
                  context: context,
                  logoutTitle: logoutTitle!,
                  logoutPress: onLogoutPress,
                  logoutStyle: logoutStyle,
                  logoutTitleColor: logoutTitleColor ?? Colors.white),
            if (appVersion != null)
              Container(
                margin: const EdgeInsets.only(left: 16, bottom: 10),
                child: Text(
                  appVersion!,
                  style: appVersionStyle,
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget _buildStupiditySwitch(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: CustomSwitchWithTitleDescription(
      onChanged: (bool value) {
        context.read<StupidityProvider>().setStupidity();
      },
      showIconAndTitle: false,
      removePadding: true,
      switchBool: context.watch<StupidityProvider>().stupidityOn,
      switchActiveColor: ColorHelper.black.color,
      subTitle: 'Turn headline text on',
    ),
  );
}

Widget _buildLogout(
    {BuildContext? context, String? logoutTitle, Function? logoutPress, TextStyle? logoutStyle, Color logoutTitleColor = Colors.white}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () => logoutPress != null ? logoutPress() : null,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          child: Text(logoutTitle!, style: logoutStyle ?? Theme.of(context!).textTheme.titleLarge!.copyWith(color: logoutTitleColor)),
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}

Widget _tapItem(bool wrapWithMaterial, Widget listItem, VoidCallback onTap, Color? backgroundColor) {
  if (wrapWithMaterial) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: () => onTap(),
        child: listItem,
      ),
    );
  }
  return GestureDetector(
    onTap: () => onTap(),
    child: listItem,
  );
}
