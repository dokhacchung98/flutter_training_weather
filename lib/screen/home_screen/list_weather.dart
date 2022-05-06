import 'package:flutter/material.dart';
import 'package:flutter_weather/component/home/item_weather.dart';

class ListWeather extends StatelessWidget {
  const ListWeather({Key? key}) : super(key: key);

  Widget _renderItem() {
    return ItemWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          _renderItem(),
          _renderItem(),
          _renderItem(),
          _renderItem(),
          _renderItem(),
          _renderItem(),
          _renderItem(),
        ],
      ),
    );
  }
}
