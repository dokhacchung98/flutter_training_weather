import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class WeatherApi {
  late final Client _client;

  WeatherApi(this._client);

  Future getWeatherDayOfCity(String cityName) async {
    try {} catch (err) {
      debugPrint('WeatherApi getWeatherDayOfCity error: ${err.toString()}');
    }
    return null;
  }

  Future getWeatherWeekOfCity(String city) async {
    try {} catch (err) {
      debugPrint('WeatherApi getWeatherWeekOfCity error: ${err.toString()}');
    }
  }
}
