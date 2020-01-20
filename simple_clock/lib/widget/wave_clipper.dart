import 'dart:ui';

import 'package:flutter/material.dart';

///
/// WaveClipper object to draw wave lines
///
class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveToDrawList = [];

  WaveClipper(this.animation, this.waveToDrawList);

  @override
  Path getClip(Size size) {
    // Create wave line
    Path path = Path();
    path.addPolygon(waveToDrawList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) {
    return animation != oldClipper.animation;
  }
}
