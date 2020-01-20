// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:simple_clock/theme/app_theme.dart';
import 'package:simple_clock/widget/wave_widget.dart';

import 'helper/wave_helper.dart';

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    print(widget.model.temperatureString);
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width, 200.0);

    final colors = Theme.of(context).brightness == Brightness.light
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    var format = _getTimeFormat();
    final minute = DateFormat('mm').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 12;
    final fontSizeSmall = MediaQuery.of(context).size.width / 40;

    final defaultStyle = TextStyle(
      color: colors[ThemeElement.text],
      fontFamily: 'PressStart2P',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 10,
          color: colors[ThemeElement.shadow],
        ),
      ],
    );
    final smallFontStyle = TextStyle(
      color: colors[ThemeElement.text],
      fontFamily: 'PressStart2P',
      fontSize: fontSizeSmall,
      shadows: [
        Shadow(
          blurRadius: 10,
          color: colors[ThemeElement.shadow],
        ),
      ],
    );

    return Column(children: <Widget>[
      Container(
        color: colors[ThemeElement.background],
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  getWeatherIcon(widget.model.weatherString),
                  color: Colors.white,
                  size: 100,
                )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DefaultTextStyle(
                    style: defaultStyle,
                    child: Row(
                      children: <Widget>[
                        Text(hour),
                        Text(":"),
                        Text(minute),
                        Text(" " + format)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
                style: smallFontStyle, child: Text(widget.model.location))
          ],
        ),
      ),
      Expanded(child: _getWaveWidgets(size, colors))
    ]);
  }

  /// Get the bottom wave widgets
  Widget _getWaveWidgets(Size size, Map<ThemeElement, Color> color) {
    return Container(
        color: color[ThemeElement.background],
        child: Align(
            alignment: Alignment.bottomRight,
            child: Stack(
              children: <Widget>[
                Opacity(
                    opacity: 0.15,
                    child: WaveWidget(
                      size: size,
                      yOffset: 20,
                      xOffset: 0,
                      color: color[ThemeElement.wave1],
                      waveDuration: 4,
                    )),
                Opacity(
                    opacity: 0.2,
                    child: WaveWidget(
                      size: size,
                      yOffset: 70,
                      xOffset: 100,
                      color: color[ThemeElement.wave2],
                    ))
              ],
            )));
  }

  /// Get time format based on the current time, ex: 'AM' or 'PM'
  String _getTimeFormat() {
    final timeOfDay = TimeOfDay.fromDateTime(_dateTime);
    var format = "AM";
    if (timeOfDay.period == DayPeriod.pm) {
      format = "PM";
    } else {
      format = "AM";
    }
    return format;
  }
}
