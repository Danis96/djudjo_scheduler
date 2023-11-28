import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/drawer/custom_drawer.dart';
import '../../../widgets/loaders/loader_app_dialog.dart';
import '../../providers/login_provider/login_provider.dart';
import '../../utils/drawer_helper.dart';
import '../../utils/language_strings.dart';

Widget buildDrawer(BuildContext context) {
  final DrawerHelper _drawerHelper = DrawerHelper();

  return CustomDrawer(
    widgetKey: const Key('home_page_drawer_key'),
    actionKey: const Key('drawer_action_home_page_key'),
    onDrawerItemPressed: (String value) {},
    onDrawerOpened: (String value) {},
    wrapWithMaterial: true,
    headerHeight: 208,
    backgroundColor: ColorHelper.black.color,
    actionIconColor: ColorHelper.white.color,
    logoutTitle: 'Logout',
    onLogoutPress: () async {
      customLoaderCircleWhite(context: context);
      await context.read<LoginProvider>().logout().then((String? error) {
        Navigator.of(context).pop();
        if (error != null) {
          customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(Login, (Route<dynamic> route) => false);
        }
      });
    },
    onActionIconPress: () => Navigator.of(context).pop(),
    listItems: _drawerHelper.drawerListItems(context),
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerNavy2.color),
    logoutStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: ColorHelper.towerNavy2.color, fontFamily: 'SourceSansPro'),
    customHeader: Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/ic_logo.png', scale: 10),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: ColorHelper.white.color,
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.close),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 5),
          // todo get user data and show email
          // Text(
          //   userProfileProvider.user.email,
          //   style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12),
          // )
        ],
      ),
    ),
  );
}