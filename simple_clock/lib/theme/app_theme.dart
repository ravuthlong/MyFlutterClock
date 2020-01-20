import 'package:flutter/material.dart';

enum ThemeElement { background, text, shadow, wave1, wave2 }

class AppTheme {
  static final lightTheme = {
    ThemeElement.background: Colors.grey,
    ThemeElement.text: Colors.white,
    ThemeElement.shadow: Colors.black,
    ThemeElement.wave1: Colors.greenAccent,
    ThemeElement.wave2: Colors.lightBlueAccent
  };

  static final darkTheme = {
    ThemeElement.background: Colors.black54,
    ThemeElement.text: Colors.white,
    ThemeElement.shadow: Colors.black,
    ThemeElement.wave1: Colors.lightGreen,
    ThemeElement.wave2: Colors.deepPurple
  };
}
