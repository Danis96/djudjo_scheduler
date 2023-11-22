import 'package:flutter/material.dart';


class TabBarModel {
  const TabBarModel({this.title});

  final String? title;
}

PreferredSizeWidget customTabBar({
  @required Key? widgetKey,
  @required List<TabBarModel>? items,
  Color? labelColor = Colors.white,
  Color? indicatorColor = Colors.transparent,
  Color? unselectedLabelColor,
  bool hasIndicator = false,
  Function(int)? onTapTabItem,
  FontWeight? fontWeight,
}) {
  return TabBar(
    key: widgetKey,
    labelColor: labelColor,
    indicatorColor: hasIndicator ? indicatorColor : Colors.transparent,
    unselectedLabelColor: unselectedLabelColor,
    indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
    indicatorSize: TabBarIndicatorSize.label,
    onTap: (int i) {
      if (onTapTabItem != null) {
        onTapTabItem(i);
      }
    },
    tabs: items!
        .map((TabBarModel e) =>
            Tab(child: Text(e.title!, textAlign: TextAlign.center, style: TextStyle(fontWeight: fontWeight ?? FontWeight.w400, fontSize: 18))))
        .toList(),
  );
}
