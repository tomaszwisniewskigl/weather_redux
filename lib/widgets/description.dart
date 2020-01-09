import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String description;

  Description({Key key, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Text(description,
            style: TextStyle(fontSize: 15)),
      )
    );
  }
}
