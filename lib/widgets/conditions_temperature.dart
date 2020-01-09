import 'package:flutter/material.dart';
import 'package:weather_redux/models/models.dart';
import 'package:weather_redux/widgets/widgets.dart';

class ConditionsTemperature extends StatelessWidget {
  final Weather weather;

  ConditionsTemperature({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Conditions(iconCode: weather.iconCode, size: 100,),
        Temperature(temperature: weather.temperature, size: 100,)
      ],
    );
  }
}