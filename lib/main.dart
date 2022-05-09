import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/language_bloc.dart';
import 'package:flutter_weather/bloc/language_state.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:flutter_weather/bloc/weather_seven_day_bloc.dart';
import 'package:flutter_weather/network/weather_api.dart';
import 'package:flutter_weather/repository/city_repository.dart';
import 'package:flutter_weather/repository/language_repository.dart';
import 'package:flutter_weather/repository/weather_repository.dart';
import 'package:flutter_weather/router/my_router.dart';

import 'common/router_constant.dart';
import 'localization/app_localizations.dart';
import 'network/client_api.dart';

void main() {
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    clientApi = ClientApi();
    final WeatherApi weatherApi = WeatherApi(clientApi.client);
    _languageRepository = LanguageRepository();
    _cityRepository = CityRepositoryImpl();
    _weatherRepository = WeatherRepositoryImpl(weatherApi);
  }

  late final LanguageRepository? _languageRepository;
  late final CityRepository? _cityRepository;
  late final WeatherRepository? _weatherRepository;
  late final ClientApi clientApi;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LanguageBloc>(
            create: (BuildContext context) => LanguageBloc(_languageRepository),
          ),
          BlocProvider<CityBloc>(
            create: (BuildContext context) => CityBloc(_cityRepository),
          ),
          BlocProvider<WeatherBLoC>(
            create: (BuildContext context) => WeatherBLoC(
              _weatherRepository,
              BlocProvider.of<CityBloc>(context),
              BlocProvider.of<LanguageBloc>(context),
            ),
          ),
          BlocProvider<WeatherSevenDayBloc>(
            create: (BuildContext context) => WeatherSevenDayBloc(
              _weatherRepository,
              BlocProvider.of<CityBloc>(context),
              BlocProvider.of<LanguageBloc>(context),
            ),
          ),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (BuildContext context, LanguageState state) => MaterialApp(
            useInheritedMediaQuery: true,
            locale: Locale(state.lang, state.lang == 'vi' ? 'VN' : 'US'),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: [Locale('vi', 'VN'), Locale('en', 'US')],
            onGenerateRoute: MyRouter.generateRoute,
            initialRoute: RouterConstant.routerHome,
          ),
        ));
  }
}
