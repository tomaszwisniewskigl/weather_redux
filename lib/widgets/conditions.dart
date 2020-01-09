import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Conditions extends StatelessWidget {
  final String iconCode;
  final double size;

  Conditions({Key key, this.iconCode, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoxedIcon(
        _mapIconCodeToIconData(iconCode),
        size: size,
      );
  }

  IconData _mapIconCodeToIconData(iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '02n':
        return WeatherIcons.day_cloudy;
      case '03d':
      case '04d':
        return WeatherIcons.day_cloudy;
      case '03n':
      case '04n':
        return WeatherIcons.night_clear;
      case '09d':
        return WeatherIcons.day_showers;
      case '09n':
        return WeatherIcons.night_rain;
      case '10d':
        return WeatherIcons.day_rain;
      case '10n':
        return WeatherIcons.night_rain;
      case '11d':
        return WeatherIcons.day_thunderstorm;
      case '11n':
        return WeatherIcons.night_thunderstorm;
      case '13d':
        return WeatherIcons.day_snow;
      case '13n':
        return WeatherIcons.night_snow;
      case '50d':
        return WeatherIcons.day_fog;
      case '50n':
        return WeatherIcons.night_fog;
      default:
        return WeatherIcons.day_sunny;
    }
  }
}
