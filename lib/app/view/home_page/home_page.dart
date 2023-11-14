import 'package:flutter/material.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/drawer/custom_drawer.dart';
import '../../../widgets/tappable_texts/custom_tappable_text.dart';
import '../../utils/drawer_helper.dart';
import '../../utils/language_strings.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),
      backgroundColor: ColorHelper.towerNavy2.color,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
    context,
    color: ColorHelper.towerNavy2.color,
    icon: Icons.menu_rounded,
    leadingIconColor: ColorHelper.white.color,
    onLeadingTap: () => _scaffoldKey.currentState!.openDrawer(),
    action: IconButton(
      onPressed: () {
        print('Add new appointment');
      },
      icon: const Icon(Icons.add),
    ),
  );

  Widget _buildDrawer(BuildContext context) {
    final DrawerHelper _drawerHelper = DrawerHelper();

    return CustomDrawer(
      widgetKey: const Key('home_page_drawer_key'),
      actionKey: const Key('drawer_action_home_page_key'),
      onDrawerItemPressed: (String value) {},
      onDrawerOpened: (String value) {},
      wrapWithMaterial: true,
      headerHeight: 208,
      backgroundColor: ColorHelper.white.color,
      actionIconColor: ColorHelper.white.color,
      logoutTitle: 'Logout',
      onLogoutPress: () => print('Logout'),
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

  Widget _buildBody(BuildContext context) {
    return ListView(shrinkWrap: true, children: <Widget>[]);
  }

}
