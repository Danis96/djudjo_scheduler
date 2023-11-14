import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    this.tapKey,
    this.title,
    this.routeName,
    this.widgetKey,
    this.titleColor = Colors.white,
    this.arguments,
    this.textStyle,
    this.iconData,
    this.margin = const EdgeInsets.only(bottom: 30, left: 15),
    this.isLink = false,
    this.boxFit = BoxFit.fitWidth,
  });

  final String? title;
  final String? routeName;
  final Key? widgetKey;
  final Color? titleColor;
  final dynamic arguments;
  final Key? tapKey;
  final BoxFit boxFit;
  final TextStyle? textStyle;
  final EdgeInsets margin;
  final bool? isLink;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widgetKey,
      margin: margin,
      child: Row(
        children: <Widget>[
          if (iconData != null) Icon(iconData, color: Colors.red, size: 22) else const SizedBox(),
          Flexible(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                width: 220,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text(title!,
                    style: textStyle != null ? textStyle! : Theme.of(context).textTheme.titleLarge!.copyWith(color: titleColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
