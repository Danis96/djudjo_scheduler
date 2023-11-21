import 'package:flutter/material.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet({
    this.height = 512,
    this.onClosePressed,
    this.title = '',
    this.bottomWidget,
    this.widgetKey,
    this.bodyWidget,
    this.topIcon,
    this.shouldUseHeight = true,
    this.searchWidget,
  });

  final Key? widgetKey;
  final double height;
  final Function? onClosePressed;
  final String title;
  final Widget? bottomWidget;
  final Widget? bodyWidget;
  final Widget? topIcon;
  final bool shouldUseHeight;
  final Widget? searchWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widgetKey,
      height: shouldUseHeight ? height : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 9),
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                size: 25,
                color: Color.fromRGBO(177, 177, 177, 1),
              ),
              onTap: () => onClosePressed!(),
            ),
          ),
          const SizedBox(height: 10),
          if (topIcon != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: topIcon!,
            ),
          if (title.isNotEmpty)
            Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall)
          else
            const SizedBox(),
          SizedBox(height: searchWidget != null ? 0 : 15),
          if (searchWidget != null) searchWidget!,
          const SizedBox(height: 10),
          if (bodyWidget != null)
            Expanded(
              child: bodyWidget!,
            ),
          const SizedBox(height: 28),
          if (bottomWidget != null) bottomWidget!,
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
