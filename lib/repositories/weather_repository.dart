import 'package:flutter/widgets.dart';
import 'package:weather/weather.dart';

class WeatherRepository {
  WeatherStation weatherStation;

  WeatherRepository({@required this.weatherStation}):assert(weatherStation != null);

  Future<List<Weather>> queryForcast() async {
    return await weatherStation.fiveDayForecast();
  }

  Future<Weather> queryWeather() async {
    return await weatherStation.currentWeather();
  }

}