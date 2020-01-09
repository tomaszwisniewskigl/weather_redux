import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:weather_redux/redux/redux_exports.dart';

import 'theme_state.dart';

class ThemeChangedAction {
  ThemeChangedAction();
}

final themeChangeReducer = combineReducers<ThemeState>([
  TypedReducer<ThemeState, ThemeChangedAction>(onThemeChange),
]);

ThemeState onThemeChange(ThemeState state, ThemeChangedAction action) {
  return ThemeState(
    theme: state.theme.brightness == Brightness.light ? ThemeData.dark() : ThemeData.light(),
  );
}
