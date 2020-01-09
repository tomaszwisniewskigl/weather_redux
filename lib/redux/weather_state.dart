import 'package:weather_redux/models/models.dart';

class WeatherState {
  Weather weather;
  List<Weather> forecast;
  bool isLoading;
  bool hasError;
  bool isEmpty;
  bool hasLoaded;

  WeatherState({
    this.weather,
    this.forecast,
    this.hasError = false,
    this.isLoading = false,
    this.isEmpty = false,
    this.hasLoaded = false,
  });

  factory WeatherState.initial() => WeatherState(isEmpty: true);
  factory WeatherState.loading() => WeatherState(isLoading: true);
  factory WeatherState.error() => WeatherState(hasError: true);
  factory WeatherState.loaded() => WeatherState(hasLoaded: true);

}