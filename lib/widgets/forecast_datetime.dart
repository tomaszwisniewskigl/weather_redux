import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastDateTime extends StatelessWidget {
  final DateTime dateTime;

  ForecastDateTime({Key key, this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${new DateFormat.E().format(dateTime)}, ${new DateFormat.j().format(dateTime)}'
    );
  }
}

