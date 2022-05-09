import 'package:flutter_weather/model/current_weather_model.dart';
import 'package:flutter_weather/model/weather_seven_day_model.dart';
import 'package:flutter_weather/network/weather_api.dart';

abstract class WeatherRepository {
  Future<CurrentWeatherModel?> getWeatherCurrentDay(String cityName, {String lang = 'vi'});

  Future<List<WeatherSevenDayModel>> getWeather7Days(String cityName, {String lang = 'vi'});
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi weatherApi;

  WeatherRepositoryImpl(this.weatherApi);

  @override
  Future<List<WeatherSevenDayModel>> getWeather7Days(String cityName,
      {String lang = 'vi'}) async {
    return await weatherApi.getWeatherWeekOfCity(cityName, lang);
  }

  @override
  Future<CurrentWeatherModel?> getWeatherCurrentDay(String cityName,
      {String lang = 'vi'}) async {
    return await weatherApi.getWeatherDayOfCity(cityName, lang);
  }
}
