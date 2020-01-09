import 'package:meta/meta.dart';
import 'redux_exports.dart';

class GlobalState {
  WeatherState weatherState;
  ThemeState themeState;

  GlobalState({@required this.weatherState, @required this.themeState})
      : assert(weatherState != null);

  factory GlobalState.initial() => GlobalState(
        weatherState: WeatherState.initial(),
        themeState: ThemeState.initial(),
      );
}

GlobalState globalReducer(GlobalState state, action) {
  return GlobalState(
    weatherState: weatherReducer(state.weatherState, action),
    themeState: themeChangeReducer(state.themeState, action),
  );
}
