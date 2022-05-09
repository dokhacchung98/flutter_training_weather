import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/common/image_animation.dart';
import 'package:flutter_weather/common/resource_img_constant.dart';
import 'package:flutter_weather/common/style_text.dart';
import 'package:flutter_weather/model/weather_seven_day_model.dart';

class ItemWeather extends StatelessWidget {
  final WeatherSevenDayModel weatherSevenDayModel;

  const ItemWeather(this.weatherSevenDayModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weatherSevenDayModel.dtTxt ?? '',
            style: StyleTextConstant.styleTexDayOfWeek,
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: FlareActor(
                    ResourceImgConstant.imgFlareWeather,
                    animation: ImageAnimation.mapNameIcon(
                        weatherSevenDayModel.weather?[0].icon),
                    isPaused: true,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Text(
                    weatherSevenDayModel.weather?[0].description ?? '',
                    style: StyleTextConstant.styleTextTemperature,
                  ),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.arrow_upward,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextSpan(
                  text: "${weatherSevenDayModel.main!.tempMax}°",
                  style: StyleTextConstant.styleTextTemperatureItemMax,
                ),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0, left: 10),
                    child: Icon(
                      Icons.arrow_downward,
                      size: 15,
                      color: Colors.white70,
                    ),
                  ),
                ),
                TextSpan(
                  text: "${weatherSevenDayModel.main!.tempMin}°",
                  style: StyleTextConstant.styleTextTemperatureItemMin,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
