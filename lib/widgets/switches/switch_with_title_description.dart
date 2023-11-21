import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitchWithTitleDescription extends StatelessWidget {
  const CustomSwitchWithTitleDescription({
    Key? key,
    this.switchBool = false,
    required this.onChanged,
    this.title = '',
    this.subTitle = '',
    this.icon = const Icon(Icons.info_outline, color: Color.fromRGBO(158, 158, 158, 1)),
    this.onIconPressed,
    this.showIconAndTitle = true,
    this.removePadding = false,
    this.switchActiveColor = Colors.green,
    this.bottomWidget,
    this.titleTextStyle = const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Color.fromRGBO(97, 97, 97, 1)),
    this.subTitleTextStyle = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Color.fromRGBO(110, 110, 110, 1)),
  }) : super(key: key);

  final bool switchBool;
  final bool showIconAndTitle;
  final bool removePadding;
  final Function(bool) onChanged;
  final String title;
  final String subTitle;
  final Icon icon;
  final Function? onIconPressed;
  final Color switchActiveColor;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: removePadding ? 0 : 24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: <Widget>[
            if (showIconAndTitle) _textAndInfo(context) else const SizedBox(),
            _textAndSwitch(context),
            const SizedBox(height: 10),
            if (bottomWidget != null) bottomWidget! else const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _textAndInfo(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Container(width: 230, child: Text(title, style: titleTextStyle))),
        IconButton(
            key: const Key('switch_w_title_desc_icon'), onPressed: () => onIconPressed != null ? onIconPressed!() : null, icon: icon),
      ],
    );
  }

  Widget _textAndSwitch(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Container(width: 230, child: Text(subTitle, style: subTitleTextStyle))),
        const SizedBox(width: 10),
        CupertinoSwitch(
            key: const Key('switch_w_title_desc_switch'),
            value: switchBool,
            onChanged: (bool value) => onChanged(value),
            activeColor: switchActiveColor),
      ],
    );
  }
}
