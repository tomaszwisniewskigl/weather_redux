import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:weather/weather.dart' as API;
import 'package:weather_redux/models/models.dart';
import 'package:weather_redux/redux/redux_exports.dart';
import 'package:weather_redux/repositories/repositories.dart';

class WeatherLoadingAction {}

class WeatherErrorAction {}

class WeatherResultAction {
  API.Weather weather;
  List<API.Weather> forecast;
  WeatherResultAction(this.weather, this.forecast);
}

class WeatherLocalResultAction {
  Weather weather;
  List<Weather> forecast;
  WeatherLocalResultAction(this.weather, this.forecast);
}

final weatherReducer = combineReducers<WeatherState>([
  TypedReducer<WeatherState, WeatherLoadingAction>(_onLoad),
  TypedReducer<WeatherState, WeatherErrorAction>(_onError),
  TypedReducer<WeatherState, WeatherResultAction>(_onResult),
  TypedReducer<WeatherState, WeatherLocalResultAction>(_onLocalResult),
]);

ThunkAction<GlobalState> loadWeatherFromLocalRepository() {
  return (Store<GlobalState> store) async {
    final local = WeatherLocalRepository();
    final weather = await local.readWeather();
    if (weather != null) {
      final forecast = await local.readForecast();
      store.dispatch(WeatherLocalResultAction(weather, forecast));
    } else {
      print('no local data found');
    }
  };
}

ThunkAction<GlobalState> refreshWeatherAction() {
  String key = '0564002b5184fdec8bc3116ba30a45f1';

  return (Store<GlobalState> store) async {
    API.WeatherStation weatherStation = new API.WeatherStation(key);
    WeatherRepository repository =
        WeatherRepository(weatherStation: weatherStation);

    try {
      API.Weather weather = await repository.queryWeather();
      List<API.Weather> forecast = await repository.queryForcast();
      store.dispatch(WeatherResultAction(weather, forecast));
    } catch (e) {
      print(e.toString());
      store.dispatch(WeatherErrorAction());
    }
  };
}

WeatherState _onLoad(WeatherState state, WeatherLoadingAction action) {
  return WeatherState.loading();
}

WeatherState _onError(WeatherState state, WeatherErrorAction action) {
  return WeatherState.error();
}

WeatherState _onResult(WeatherState state, WeatherResultAction action) {
  Weather weather = apiWeatherToWeather(action.weather);
  List<Weather> forecast = apiForectastToForecast(action.forecast);
  final localRepository = WeatherLocalRepository();
  localRepository.storeWeather(weather);
  localRepository.storeForecast(forecast);
  return WeatherState(weather: weather, forecast: forecast, hasLoaded: true);
}

WeatherState _onLocalResult(WeatherState state, WeatherLocalResultAction action) {
  return WeatherState(weather: action.weather, forecast: action.forecast, hasLoaded: true);
}

List<Weather> apiForectastToForecast(List<API.Weather> forecast) {
  return forecast.map((f) => apiWeatherToWeather(f)).toList();
}

Weather apiWeatherToWeather(API.Weather weather) {
  return new Weather(
      weather.temperature.celsius.round(),
      weather.weatherIcon,
      weather.weatherDescription,
      weather.areaName,
      weather.date);
}
