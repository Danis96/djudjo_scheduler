import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.buttonTitle = '',
    required this.onPressed,
    this.disabled = false,
    this.style,
    this.btnTitleStyle,
    this.forceStyleOverGradient = false,
    this.width,
    this.minWidth,
    this.padding = 10,
  }) : super(key: key);

  final String buttonTitle;
  final bool disabled;
  final Function? onPressed;
  final ButtonStyle? style;
  final TextStyle? btnTitleStyle;
  final double padding;

  ///used to force style gradient
  final bool forceStyleOverGradient;
  final double? width;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
      width: width,
      child: ElevatedButton(
        onPressed: disabled
            ? null
            : () {
                if (onPressed != null) {
                  onPressed!();
                }
              },
        style: ElevatedButton.styleFrom(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          visualDensity: VisualDensity.compact,
        ),
        child: Padding(padding: EdgeInsets.all(padding), child: Text(buttonTitle, textAlign: TextAlign.center, style: btnTitleStyle)),
      ),
    );
  }
}
