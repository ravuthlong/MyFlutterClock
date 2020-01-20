import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_clock/widget/wave_clipper.dart';
import 'package:vector_math/vector_math.dart' as Vector;

class WaveWidget extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;
  final int waveDuration;

  WaveWidget(
      {Key key,
      @required this.size,
      this.xOffset,
      this.yOffset,
      this.color,
      this.waveDuration = 2})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WaveWidgetState();
  }
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();
    _setAnimationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) => ClipPath(
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          color: widget.color,
        ),
        clipper: WaveClipper(_controller.value, animList1),
      ),
    );
  }

  void _setAnimationController() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.waveDuration));

    _controller.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(Offset(
            i.toDouble() + widget.xOffset,
            sin((_controller.value * 360 - i) % 360 * Vector.degrees2Radians) *
                    15 +
                50 +
                widget.yOffset));
      }
    });
    _controller.repeat();
  }
}
