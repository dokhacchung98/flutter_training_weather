import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/city_state.dart';
import 'package:flutter_weather/bloc/language_bloc.dart';
import 'package:flutter_weather/bloc/language_state.dart';
import 'package:flutter_weather/bloc/weather-event.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/current_weather_model.dart';
import 'package:flutter_weather/repository/weather_repository.dart';

class WeatherBLoC extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository? weatherRepository;
  final CityBloc cityBloc;
  final LanguageBloc languageBloc;

  late StreamSubscription _cityStreamSubscription;
  late StreamSubscription _langStreamSubscription;

  WeatherBLoC(this.weatherRepository, this.cityBloc, this.languageBloc)
      : super(FetchingWeatherState()) {
    _cityStreamSubscription = cityBloc.stream.listen((state) {
      if (state is ChangeListCitiesOrCurrentCityState) {
        add(WeatherStartFetchDataEvent(
            state.currentCityModel.nameCity!, languageBloc.state.lang));
      }
    });

    _langStreamSubscription = languageBloc.stream.listen((state) {
      if (state is LanguageChangeState &&
          cityBloc.state.currentCityModel.nameCity != null &&
          !cityBloc.state.currentCityModel.nameCity!.isEmpty) {
        add(WeatherStartFetchDataEvent(
            cityBloc.state.currentCityModel.nameCity!, state.lang));
      }
    });

    on<WeatherStartFetchDataEvent>(_onStartFetchDataEvent);
  }

  Future _onStartFetchDataEvent(
      WeatherStartFetchDataEvent event, Emitter<WeatherState> emitter) async {
    try {
      if (weatherRepository == null) return;
      CurrentWeatherModel? res = await weatherRepository!
          .getWeatherCurrentDay(event.country, lang: event.lang);
      if (res != null) {
        emitter(WeatherFetchSuccessState(res));
      } else {
        throw 'Exception casting json to model';
      }
    } catch (err) {
      debugPrint("WeatherBLoc _onStartFetchDataEvent error $err");
      emitter(WeatherFetchErrorState('err'));
    }
  }
}
