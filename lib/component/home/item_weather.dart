import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/common/resource_img_constant.dart';
import 'package:flutter_weather/common/style_text.dart';

class ItemWeather extends StatelessWidget {
  const ItemWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'WED',
              style: StyleTextConstant.styleTexDayOfWeek,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: FlareActor(
                    ResourceImgConstant.imgFlareWeather,
                    animation: "sunny",
                    isPaused: true,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: RichText(
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
                    text: "32",
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
                    text: "23",
                    style: StyleTextConstant.styleTextTemperatureItemMin,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
