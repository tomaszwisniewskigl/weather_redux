import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  final int temperature;
  final double size;

  Temperature({Key key, this.temperature, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      temperature.toString() + '°',
      style: TextStyle(fontSize: size),
    );
  }
}
