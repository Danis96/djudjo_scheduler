import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    this.title = '',
    this.imageUrl = '',
    this.titleTextStyle = const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Color.fromRGBO(28, 37, 53, 1)),
    this.onTap,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.imgFit = BoxFit.contain,
    this.hideOnTap = false,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final TextStyle titleTextStyle;
  final Function? onTap;
  final CrossAxisAlignment crossAxisAlignment;
  final BoxFit imgFit;
  final bool hideOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null ? null : () => onTap!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0, left: 20.0, right: 24.0),
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: <Widget>[
            Expanded(flex: 1, child: Image.asset(imageUrl.isNotEmpty ? imageUrl : 'assets/logo_bez.png', fit: imgFit, height: 40)),
            const SizedBox(width: 18),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 34.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: titleTextStyle, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
           if (hideOnTap) const SizedBox(width: 17) else const Icon(Icons.arrow_forward_ios_rounded, size: 17),
          ],
        ),
      ),
    );
  }
}
