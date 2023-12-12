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
    headerHeight: 200,
    backgroundColor: ColorHelper.white.color,
    logoutTitle: Language.hd_logout_title,
    onLogoutPress: () async {
      customSimpleDialog(
        context,
        buttonText: Language.hd_cancel,
        buttonTwoText: 'Ok',
        onButtonTwoPressed: () => _logout(context),
        onButtonPressed: () => Navigator.of(context).pop(),
        title: Language.hd_title,
        content: Language.hd_content,
      );
    },
    listItems: _drawerHelper.drawerListItems(context),
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.black.color),
    logoutStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: ColorHelper.black.color),
    customHeader: Image.asset('assets/dr_back.png', width: double.infinity, fit: BoxFit.fill),
  );
}

Future<void> _logout(BuildContext context) async {
  customLoaderCircleWhite(context: context);
  await context.read<LoginProvider>().logout().then((String? error) {
    Navigator.of(context).pop();
    if (error != null) {
      customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(Login, (Route<dynamic> route) => false);
    }
  });
}
