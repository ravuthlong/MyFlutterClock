import 'package:flutter/material.dart';

///
/// Returns weather icon based on weather string
///
IconData getWeatherIcon(String string) {
  IconData _weatherIcon;
  switch (string) {
    case 'cloudy':
      _weatherIcon = Icons.cloud;
      break;
    case 'foggy':
      _weatherIcon = Icons.texture;
      break;
    case 'rainy':
      _weatherIcon = Icons.grain;
      break;
    case 'snowy':
      _weatherIcon = Icons.ac_unit;
      break;
    case 'sunny':
      _weatherIcon = Icons.wb_sunny;
      break;
    case 'thunderstorm':
      _weatherIcon = Icons.flash_on;
      break;
    case 'windy':
      _weatherIcon = Icons.flag;
      break;
    default:
      _weatherIcon = Icons.wb_sunny;
      break;
  }
  return _weatherIcon;
}
