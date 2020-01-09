import 'package:flutter/material.dart';
import 'package:weather_redux/models/models.dart';
import 'package:weather_redux/widgets/widgets.dart';

class Forecast extends StatelessWidget {
  final List<Weather> forecast;

  Forecast({Key key, @required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: new SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: forecast
                  .map((f) => ForecastItem(
                        weather: f,
                      ))
                  .toList())),
    );
  }
}
