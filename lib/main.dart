import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weather_redux/redux/redux_exports.dart';
import 'package:weather_redux/widgets/widgets.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = new Store<GlobalState>(
    globalReducer,
    initialState: GlobalState.initial(),
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(
    store: store,
  ));
  store.dispatch(loadWeatherFromLocalRepository());
}

class MyApp extends StatefulWidget {
  final Store<GlobalState> store;

  MyApp({
    Key key,
    this.store,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<GlobalState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Weather Redux',
        theme: widget.store.state.themeState.theme,
        home: WeatherPage(),
      ),
    );
  }
}
