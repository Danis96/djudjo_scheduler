import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text_fields/custom_text_form_field.dart';

class CustomSwitchWithTitleDescriptionInputField extends StatelessWidget {
  const CustomSwitchWithTitleDescriptionInputField({
    Key? key,
    this.switchBool = false,
    required this.onChanged,
    this.title = '',
    this.subTitle = '',
    this.fieldInputTitle = '',
    this.icon = const Icon(Icons.info_outline, color: Color.fromRGBO(158, 158, 158, 1)),
    this.onIconPressed,
    this.switchActiveColor = Colors.green,
    this.titleTextStyle = const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Color.fromRGBO(97, 97, 97, 1)),
    this.subTitleTextStyle = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Color.fromRGBO(110, 110, 110, 1)),
    this.fieldInputTitleTextStyle = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Color.fromRGBO(33, 33, 33, 1)),
    required this.fieldController,
  }) : super(key: key);

  final bool switchBool;
  final Function(bool) onChanged;
  final String title;
  final String subTitle;
  final String fieldInputTitle;
  final Icon icon;
  final Function? onIconPressed;
  final Color switchActiveColor;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final TextStyle fieldInputTitleTextStyle;
  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        elevation: 5.4,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: <Widget>[
              _textAndInfo(),
              _textAndSwitch(),
              const SizedBox(height: 24.0),
              _inputField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textAndInfo() {
    return Row(
      children: <Widget>[
        Expanded(child: Container(width: 230, child: Text(title, style: titleTextStyle))),
        IconButton(
            key: const Key('switch_w_title_desc_field_icon'), onPressed: () => onIconPressed != null ? onIconPressed!() : null, icon: icon),
      ],
    );
  }

  Widget _textAndSwitch() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(width: 230, child: Text(subTitle, style: subTitleTextStyle)),
        )),
        CupertinoSwitch(
            key: const Key('switch_w_title_desc_field_switch'),
            value: switchBool,
            onChanged: (bool value) => onChanged(value),
            activeColor: switchActiveColor),
      ],
    );
  }

  Widget _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(fieldInputTitle, style: fieldInputTitleTextStyle),
        CustomTextFormField(
          fKey: const Key('aw_switch_with_title_description_input_field'),
          label: '',
          hintText: '0.0',
          controller: fieldController,
          readOnly: !switchBool,
        ),
      ],
    );
  }
}
