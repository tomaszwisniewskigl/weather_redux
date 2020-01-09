import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final String location;

  Location({Key key, this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(Icons.location_on),
          ),
          Text(location,
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
