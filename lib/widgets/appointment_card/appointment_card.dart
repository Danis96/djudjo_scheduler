import 'package:djudjo_scheduler/app/utils/constants/constants.dart';
import 'package:djudjo_scheduler/theme/color_helper.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    this.day = '',
    this.month = '',
    this.phone = '',
    this.name = '',
    this.time = '',
    this.dotColor = Colors.white,
    this.finished = false,
    this.onCardPressed,
  });

  final String day;
  final String month;
  final String time;
  final String name;
  final String phone;
  final Color dotColor;
  final bool finished;
  final Function? onCardPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPressed as void Function()? ?? () {},
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: finished ? ColorHelper.black.color.withOpacity(0.3) : ColorHelper.black.color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _leftDateWidget(context, day, month),
            _rightTimeAndDataWidget(context, dotColor, name, phone, time),
          ],
        ),
      ),
    );
  }
}

Widget _leftDateWidget(BuildContext context, String day, String month) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _styledText(context, day, fontSize: 40),
        _styledText(context, month, fontSize: 14),
      ],
    ),
  );
}

Widget _rightTimeAndDataWidget(
  BuildContext context,
  Color dotColor,
  String name,
  String phone,
  String time,
) {
  return Container(
    width: 160,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTimeWidget(context, dotColor, time),
        _buildNamePhoneInfo(context, name, phone),
      ],
    ),
  );
}

Widget _buildTimeWidget(BuildContext context, Color dotColor, String time) {
  return Row(
    children: <Widget>[
      Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor)),
      const SizedBox(width: 5),
      _styledText(context, time, fontSize: 16),
    ],
  );
}

Widget _buildNamePhoneInfo(BuildContext context, String name, String phone) {
  return Container(
    margin: const EdgeInsets.only(left: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _styledText(context, name, maxLines: 1),
        _styledText(context, phone, maxLines: 1),
      ],
    ),
  );
}

Widget _styledText(BuildContext context, String text, {double fontSize = 14, int maxLines = 1}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: Theme.of(context).textTheme.displayLarge!.copyWith(
          fontFamily: FontConstants.POPPINS_FONT,
          fontSize: fontSize,
          color: ColorHelper.white.color.withOpacity(0.7),
        ),
  );
}

