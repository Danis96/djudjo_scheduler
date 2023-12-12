import 'package:djudjo_scheduler/generated/assets.dart';

class SettingsItemModel {
  SettingsItemModel({this.title = '', this.icon = '', this.route = '', this.hideIconArrow = false});

  final String title;
  final String icon;
  final String route;
  final bool hideIconArrow;
}

List<SettingsItemModel> settingsItemsGeneral = <SettingsItemModel>[
  SettingsItemModel(title: 'Profile', icon: Assets.assetsProfile),
  SettingsItemModel(title: 'Change Password', icon: Assets.assetsPassword),
  SettingsItemModel(title: 'Report a bug', icon: Assets.assetsBug),
  SettingsItemModel(title: 'Send feedback', icon: Assets.assetsFeedback),
];


List<SettingsItemModel> settingsItemsOther = <SettingsItemModel>[
  SettingsItemModel(title: 'Logout', icon: Assets.assetsLogout, hideIconArrow: true),
  SettingsItemModel(title: 'Delete account', icon: Assets.assetsDelete, hideIconArrow: true),
];
