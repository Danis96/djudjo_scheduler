import 'package:flutter/material.dart';

PreferredSizeWidget commonAppBar({
  IconData? icon = Icons.arrow_back_ios,
  Function? onLeadingTap,
  Color? leadingIconColor,
  Color? color,
  bool hideLeading = false,
}) {
  return AppBar(
    backgroundColor: color ?? Colors.transparent,
    leading: hideLeading
        ? const SizedBox()
        : GestureDetector(
            onTap: () {
              if (onLeadingTap != null) {
                onLeadingTap();
              }
            },
            child: Icon(icon, color: leadingIconColor ?? Colors.black),
          ),
  );
}
