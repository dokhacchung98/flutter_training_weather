import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/city_event.dart';
import 'package:flutter_weather/bloc/city_state.dart';
import 'package:flutter_weather/bloc/language_bloc.dart';
import 'package:flutter_weather/bloc/language_event.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/common/image_animation.dart';
import 'package:flutter_weather/common/resource_img_constant.dart';
import 'package:flutter_weather/common/style_text.dart';
import 'package:flutter_weather/localization/app_localizations.dart';

import 'change_language.dart';
import 'list_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    try {
      BlocProvider.of<CityBloc>(context).add(LoadCitiesFromDB());
      BlocProvider.of<LanguageBloc>(context).add(InitalLanguageEvent());
    } catch (err) {
      debugPrint("HomeScreen _initData error $err");
    }
  }

  Widget _renderViewChild(IconData icon, String value, String subValue) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: StyleTextConstant.styleTextTemperature,
          ),
          SizedBox(height: 4),
          Text(
            subValue,
            style: StyleTextConstant.styleTextTemperatureSubValue,
          ),
        ],
      ),
    );
  }

  _goToChooseCityScreen(BuildContext context) {
    Navigator.pushNamed(context, '/choose-city');
  }

  Future _onPullToRefresh() async {}

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white24,
      body: BlocBuilder<WeatherBLoC, WeatherState>(builder: (context, state) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAnimation.mapBackground(
                      state.weatherModel.weather?[0].icon)),
                  fit: BoxFit.fill)),
          child: RefreshIndicator(
            onRefresh: _onPullToRefresh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlueAccent.withOpacity(0.6),
                            Colors.blueAccent.withOpacity(0.9),
                          ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                        ),
                        border: Border.all(width: 1, color: Colors.white70)),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: SafeArea(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _goToChooseCityScreen(context),
                            child: BlocBuilder<CityBloc, CityState>(
                              builder: (context, state) {
                                return RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.edit_location_outlined,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.currentCityModel.nameCity
                                          ?.toUpperCase(),
                                      style:
                                          StyleTextConstant.styleTextCityLarge,
                                    ),
                                  ]),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: mediaQueryData.size.width * 0.6,
                            height: mediaQueryData.size.width * 0.6,
                            child: state is WeatherFetchSuccessState
                                ? FlareActor(
                                    ResourceImgConstant.imgFlareWeather,
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                    animation: ImageAnimation.mapNameIcon(
                                        state.weatherModel.weather?[0].icon),
                                  )
                                : state is WeatherFetchErrorState
                                    ? Container(
                                        margin: EdgeInsets.only(top: 24),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .translate("error_fetching"),
                                          style: StyleTextConstant
                                              .styleTextTemperature,
                                        ),
                                      )
                                    : Center(
                                        child: const CircularProgressIndicator(
                                            color: Colors.white)),
                          ),
                          state is WeatherFetchSuccessState
                              ? Text(
                                  "32°",
                                  style: StyleTextConstant
                                      .styleTextTemperatureLarge,
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 2,
                          ),
                          if (state is WeatherFetchSuccessState)
                            Text(
                              state is FetchingWeatherState
                                  ? "---"
                                  : '${state.weatherModel.weather?[0]?.description}',
                              style:
                                  StyleTextConstant.styleTextTemperatureSmall,
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 1, color: Colors.white30),
                            )),
                            padding: EdgeInsets.only(top: 12),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _renderViewChild(
                                  Icons.cloud,
                                  AppLocalizations.of(context)!
                                      .translate("home_wind"),
                                  state is FetchingWeatherState
                                      ? "---"
                                      : '${state.weatherModel.wind?.speed ?? '0'} m/s'),
                              _renderViewChild(
                                  Icons.remove_red_eye,
                                  AppLocalizations.of(context)!
                                      .translate("home_visibility"),
                                  state is FetchingWeatherState
                                      ? "---"
                                      : '${(state.weatherModel.visibility ?? 0) / 1000} km'),
                              _renderViewChild(
                                  Icons.water_drop,
                                  AppLocalizations.of(context)!
                                      .translate("home_humidity"),
                                  state is FetchingWeatherState
                                      ? "---"
                                      : '${state.weatherModel.main?.humidity ?? '0'} %'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 8, top: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate("home_sevenDay"),
                          style: StyleTextConstant.styleText7Day),
                    ),
                  ),
                  ListWeather(),
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 8, top: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate("home_language"),
                          style: StyleTextConstant.styleText7Day),
                    ),
                  ),
                  ChangeLanguage(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
