import 'package:djudjo_scheduler/app/utils/helpers/settings_helper.dart';
import 'package:djudjo_scheduler/widgets/prize_item/inbox_list_item.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../utils/language/language_strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
      context,
      color: ColorHelper.white.color,
      title: 'Settings',
      titleColor: Colors.black,
      icon: Icons.arrow_back_ios,
      leadingIconColor: ColorHelper.black.color,
      onLeadingTap: () => Navigator.of(context).pop(),
    );

Widget _buildBody(BuildContext context) {
  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 30),
        _buildHeadline(context),
        const SizedBox(height: 50),
        _buildListOfItems(context),
        const SizedBox(height: 10),
        const Divider(),
        _buildListOfItemsOther(context),
      ],
    ),
  );
}

Widget _buildHeadline(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: <Widget>[
        Text(
          'Personalize Your Mobile Settings for a DjudjoInk Experience',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    ),
  );
}

Widget _buildListOfItems(BuildContext context) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: settingsItemsGeneral.length,
      itemBuilder: (BuildContext context, int x) {
        return CustomListItem(
          title: settingsItemsGeneral[x].title,
          imageUrl: settingsItemsGeneral[x].icon,
          hideOnTap: settingsItemsGeneral[x].hideIconArrow,
        );
      });
}

Widget _buildListOfItemsOther(BuildContext context) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: settingsItemsOther.length,
      itemBuilder: (BuildContext context, int x) {
        return CustomListItem(
          title: settingsItemsOther[x].title,
          imageUrl: settingsItemsOther[x].icon,
          hideOnTap: settingsItemsOther[x].hideIconArrow,
        );
      });
}
