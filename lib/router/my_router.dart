import 'package:flutter/material.dart';
import 'package:flutter_weather/common/router_constant.dart';
import 'package:flutter_weather/screen/choose_city_screen/choose_city_screen.dart';
import 'package:flutter_weather/screen/home_screen/home_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouterConstant.routerHome:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouterConstant.routerChooseCity:
        return MaterialPageRoute(builder: (_) => ChooseCityScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Router empty'),
            ),
          ),
        );
    }
  }
}
