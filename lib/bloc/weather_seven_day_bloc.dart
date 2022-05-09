import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/city_state.dart';
import 'package:flutter_weather/bloc/language_bloc.dart';
import 'package:flutter_weather/bloc/language_state.dart';
import 'package:flutter_weather/model/weather_seven_day_model.dart';
import 'package:flutter_weather/repository/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_seven_day_event.dart';
part 'weather_seven_day_state.dart';

class WeatherSevenDayBloc
    extends Bloc<WeatherSevenDayEvent, WeatherSevenDayState> {
  final WeatherRepository? weatherRepository;
  final CityBloc cityBloc;
  final LanguageBloc languageBloc;

  late StreamSubscription _cityStreamSubscription;
  late StreamSubscription _langStreamSubscription;

  WeatherSevenDayBloc(this.weatherRepository, this.cityBloc, this.languageBloc)
      : super(WeatherSevenDayInitialState()) {
    _cityStreamSubscription = cityBloc.stream.listen((state) {
      if (state is ChangeListCitiesOrCurrentCityState) {
        add(GetSevenDayWeatherEvent(
            state.currentCityModel.nameCity!, languageBloc.state.lang));
      }
    });

    _langStreamSubscription = languageBloc.stream.listen((state) {
      if (state is LanguageChangeState &&
          cityBloc.state.currentCityModel.nameCity != null &&
          !cityBloc.state.currentCityModel.nameCity!.isEmpty) {
        add(GetSevenDayWeatherEvent(
            cityBloc.state.currentCityModel.nameCity!, state.lang));
      }
    });
    on<GetSevenDayWeatherEvent>(_onStartFetchWeatherSevenDay);
  }

  Future _onStartFetchWeatherSevenDay(GetSevenDayWeatherEvent event,
      Emitter<WeatherSevenDayState> emitter) async {
    try {
      if (weatherRepository == null) return;
      emitter(WeatherSevenFetching());
      List<WeatherSevenDayModel> listWeatherSevenDay = await weatherRepository!
          .getWeather7Days(event.cityName, lang: event.lang);
      emitter(WeatherSevenDayFetchSuccessState(listWeatherSevenDay));
    } catch (err) {
      emitter(WeatherSevenDayFetchFaildState(err.toString()));
    }
  }
}
