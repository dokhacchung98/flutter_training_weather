import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather/common/api_constant.dart';
import 'package:flutter_weather/common/key_constant.dart';
import 'package:flutter_weather/model/current_weather_model.dart';
import 'package:flutter_weather/model/weather_seven_day_model.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WeatherApi {
  late final Client _client;

  WeatherApi(this._client);

  Future<CurrentWeatherModel?> getWeatherDayOfCity(
      String cityName, String lang) async {
    try {
      var res = await _client.get(Uri.parse(
          ('${ApiConstant.baseUrl}${ApiConstant.getCityWeatherDaySrc}?lang=$lang&appid=${KeyConstant.keyApiWeather}&q=$cityName')));
      CurrentWeatherModel currentWeatherModel =
          CurrentWeatherModel.fromJson(jsonDecode(res.body));
      return currentWeatherModel;
    } catch (err) {
      debugPrint("WeatherApi getWeatherDayOfCity error $err");
      return null;
    }
  }

  Future<List<WeatherSevenDayModel>> getWeatherWeekOfCity(
      String cityName, String lang) async {
    try {
      var res = await _client.get(Uri.parse(
          ('${ApiConstant.baseUrl}${ApiConstant.getCityWeatherWeekSrc}?lang=$lang&appid=${KeyConstant.keyApiWeather}&q=$cityName')));
      final listJsons = jsonDecode(res.body)['list'] as List;
      List<WeatherSevenDayModel> listWeatherSevenDay = listJsons
          .map((jsonObj) => WeatherSevenDayModel.fromJson(jsonObj))
          .toList();
      List<WeatherSevenDayModel> _listWeatherResponse = [];
      List _listKeyUnique = [];
      DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
      DateFormat _dateFormatDay = DateFormat('EEE', lang);
      listWeatherSevenDay.forEach((element) {
        if (!_listKeyUnique.any((t) => t == element.dtTxt)) {
          _listKeyUnique.add(element.dtTxt);
          DateTime tmpTime = _dateFormat.parse(element.dtTxt!);
          element.dtTxt = _dateFormatDay.format(tmpTime);
          _listWeatherResponse.add(element);
        }
      });
      return _listWeatherResponse;
    } catch (err) {
      debugPrint("WeatherApi getWeatherWeekOfCity error $err");
      return [];
    }
  }
}
