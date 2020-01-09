import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weather_redux/models/weather.dart';
import 'package:weather_redux/redux/redux_exports.dart';
import 'package:weather_redux/widgets/widgets.dart';
import 'package:redux/redux.dart';
import 'package:weather_redux/repositories/repositories.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  Widget buildBody(GlobalState state, Store<GlobalState> store) {
    if (state.weatherState.isEmpty) {
      return Center(
        child: Text('No weather data'),
      );
    }
    if (state.weatherState.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.weatherState.hasLoaded) {
      _refreshCompleter?.complete();
      _refreshCompleter = Completer();

      final weather = state.weatherState.weather;
      final forecast = state.weatherState.forecast;

      return RefreshIndicator(
        child: ListView(
          children: <Widget>[
            Location(
              location: weather.location,
            ),
            Description(
              description: weather.description,
            ),
            ConditionsTemperature(
              weather: weather,
            ),
            Forecast(
              forecast: forecast,
            )
          ],
        ),
        onRefresh: () {
          store.dispatch(refreshWeatherAction());
          return _refreshCompleter.future;
        },
      );
    }
    if (state.weatherState.hasError) {
      return Center(
        child: Text(
          'Something went wrong',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<GlobalState>(context);

    return StoreConnector<GlobalState, WeatherScreenViewModel>(
      converter: (store) {
        return WeatherScreenViewModel(state: store.state);
      },
      builder: (BuildContext context, WeatherScreenViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Weather Redux'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  store.dispatch(refreshWeatherAction());
                },
              ),
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  store.dispatch(ThemeChangedAction());
                },
              ),
            ],
          ),
          body: buildBody(vm.state, store),
        );
      },
    );
  }
}

class WeatherScreenViewModel {
  final GlobalState state;

  WeatherScreenViewModel({this.state});
}
