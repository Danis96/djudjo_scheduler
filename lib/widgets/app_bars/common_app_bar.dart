import 'package:flutter/material.dart';

PreferredSizeWidget commonAppBar(
  BuildContext context, {
  IconData? icon = Icons.arrow_back_ios,
  Function? onLeadingTap,
  Color? leadingIconColor,
  Color? color,
  bool hideLeading = false,
  Widget? action,
}) {
  return AppBar(
    backgroundColor: color ?? Colors.transparent,
    actions: <Widget>[
      action ?? const SizedBox()
    ],
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
