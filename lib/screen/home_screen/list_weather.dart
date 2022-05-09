import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/weather_seven_day_bloc.dart';
import 'package:flutter_weather/component/home/item_weather.dart';
import 'package:flutter_weather/localization/app_localizations.dart';
import 'package:flutter_weather/model/weather_seven_day_model.dart';

class ListWeather extends StatelessWidget {
  const ListWeather({Key? key}) : super(key: key);

  Widget _renderItem(WeatherSevenDayModel model) {
    return ItemWeather(model);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: BlocBuilder<WeatherSevenDayBloc, WeatherSevenDayState>(
        builder: (context, state) {
          if (state is WeatherSevenFetching || state is WeatherSevenDayInitialState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is WeatherSevenDayFetchSuccessState) {
            final List<WeatherSevenDayModel> listWeather =
                state.listWeatherSevenDays;
            return Column(
              children: [
                for (WeatherSevenDayModel item in listWeather)
                  _renderItem(item),
              ],
            );
          } else {
            return Text(
                AppLocalizations.of(context)!.translate("error_fetching"));
          }
        },
      ),
    );
  }
}
