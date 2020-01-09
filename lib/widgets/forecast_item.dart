import 'package:flutter/material.dart';
import 'package:weather_redux/models/models.dart';
import 'package:weather_redux/widgets/widgets.dart';

class ForecastItem extends StatelessWidget {
  final Weather weather;

  ForecastItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ForecastDateTime(dateTime: weather.dateTime,),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Conditions(iconCode: weather.iconCode, size: 20,),
          ),
          Temperature(temperature: weather.temperature, size: 15,),
        ],
      ),
    );
  }
}