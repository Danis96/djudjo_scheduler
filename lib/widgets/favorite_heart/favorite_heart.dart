import 'package:flutter/material.dart';

class FavoriteHeart extends StatefulWidget {
  FavoriteHeart({super.key, this.isSelected = false, this.onTap});

  bool isSelected;
  Function? onTap;

  @override
  State<FavoriteHeart> createState() => _FavoriteHeartState();
}

class _FavoriteHeartState extends State<FavoriteHeart> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          } else {
            print('ON_TAP == NUL');
          }
        },
        child: Icon(widget.isSelected ? Icons.favorite : Icons.favorite_border, color: widget.isSelected ? Colors.red : Colors.black));
  }
}
