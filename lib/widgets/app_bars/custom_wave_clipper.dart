import 'package:flutter/material.dart';

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double p0 = size.height * 0.75;
    path.lineTo(0.0, p0);

    final Offset controlPoint = Offset(size.width * 0.5, size.height);
    final Offset endPoint = Offset(size.width, size.height / 7);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) =>
      oldClipper != this;
}

