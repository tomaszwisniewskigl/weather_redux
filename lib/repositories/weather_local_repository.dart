import 'weather_database.dart';
import 'package:weather_redux/models/models.dart';

class WeatherLocalRepository {
  final dbHelper = WeatherDatabase.instance;

  Future<Weather> readWeather() async {
    final rowsCount = await dbHelper.queryRowCount();
    if (rowsCount > 0) {
      final rows = await dbHelper.queryAllRows();
      final weather = mapRowToWeather(rows.first);
      return weather;
    } else {
      return null;
    }
  }

  Future<List<Weather>> readForecast() async {
    final rows = await dbHelper.queryAllRows();
    final forecast = rows.map((r) {
      return mapRowToWeather(r);
    }).toList();
    return forecast;
  }

  void storeForecast(List<Weather> forecast) async {
    final rowsCount = await dbHelper.queryRowCount();
    forecast.asMap().forEach((index, weather) async {
      final row = mapWeatherToRow(weather, index + 2);
      if (rowsCount > index + 1) {
        final updated = await dbHelper.update(row);
        print('updated rows: $updated');
      } else {
        final id = await dbHelper.insert(row);
        print('inserted row id: $id');
      }
    });
  }

  void storeWeather(Weather weather) async {
    final row = mapWeatherToRow(weather, 1);
    final rowsCount = await dbHelper.queryRowCount();
    if (rowsCount > 0) {
      final updated = await dbHelper.update(row);
      print('updated rows: $updated');
    } else {
      final id = await dbHelper.insert(row);
      print('inserted row id: $id');
    }
  }

  Map<String, dynamic> mapWeatherToRow(Weather weather, int id) {
    return {
      WeatherDatabase.columnId: id,
      WeatherDatabase.columnTemperature: weather.temperature,
      WeatherDatabase.columnDateTime: weather.dateTime.toIso8601String(),
      WeatherDatabase.columnIconCode: weather.iconCode,
      WeatherDatabase.columnLocation: weather.location,
      WeatherDatabase.columnDescription: weather.description
    };
  }

  Weather mapRowToWeather(Map<String, dynamic> row) {
    final temp = row[WeatherDatabase.columnLocation];
    final date = DateTime.parse(row[WeatherDatabase.columnDateTime]);
    final weather = new Weather(
        row[WeatherDatabase.columnTemperature],
        row[WeatherDatabase.columnIconCode],
        row[WeatherDatabase.columnDescription],
        row[WeatherDatabase.columnLocation],
        DateTime.parse(row[WeatherDatabase.columnDateTime]));
    return weather;
  }
}
