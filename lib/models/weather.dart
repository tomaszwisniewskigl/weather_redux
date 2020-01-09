import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int temperature;
  final String iconCode;
  final String description;
  final String location;
  final DateTime dateTime;

  Weather(this.temperature, this.iconCode, this.description, this.location, this.dateTime);

  @override
  List<Object> get props => [temperature, iconCode, description, location, dateTime];

}
