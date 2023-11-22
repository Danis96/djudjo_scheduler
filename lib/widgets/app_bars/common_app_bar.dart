import 'package:djudjo_scheduler/theme/color_helper.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget commonAppBar(
  BuildContext context, {
  IconData? icon = Icons.arrow_back_ios,
  Function? onLeadingTap,
  Color? leadingIconColor,
  Color? color,
  Color? titleColor,
  bool hideLeading = false,
  Widget? action,
  Size? preferredSizeForBottom,
  Widget? bottomWidget,
  String? title,
}) {
  return AppBar(
    backgroundColor: color ?? Colors.transparent,
    elevation: 0,
    title: title != null
        ? Text(
            title,
            style: TextStyle(color: titleColor ?? ColorHelper.white.color, fontSize: 18),
          )
        : const SizedBox(),
    bottom: PreferredSize(preferredSize: preferredSizeForBottom ?? const Size(0, 0), child: bottomWidget ?? const SizedBox()),
    actions: <Widget>[action ?? const SizedBox()],
    leading: hideLeading
        ? const SizedBox()
        : GestureDetector(
            onTap: () {
              if (onLeadingTap != null) {
                onLeadingTap();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Icon(icon, color: leadingIconColor ?? Colors.black),
          ),
  );
}
