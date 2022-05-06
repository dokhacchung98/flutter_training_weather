import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/common/resource_img_constant.dart';
import 'package:flutter_weather/common/style_text.dart';
import 'package:flutter_weather/localization/app_localizations.dart';
import 'package:flutter_weather/screen/choose_city_screen/choose_city_screen.dart';

import 'change_language.dart';
import 'list_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseCityScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blueAccent],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(1, 1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: SafeArea(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _goToChooseCityScreen(context),
                      child: RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.edit_location_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "Hà Nội",
                            style: StyleTextConstant.styleTextCityLarge,
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      width: mediaQueryData.size.width * 0.6,
                      height: mediaQueryData.size.width * 0.6,
                      child: FlareActor(
                        ResourceImgConstant.imgFlareWeather,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        animation: "sunny_rain",
                      ),
                    ),
                    Text(
                      "32",
                      style: StyleTextConstant.styleTextTemperatureLarge,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Troi mua",
                      style: StyleTextConstant.styleTextTemperatureSmall,
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
                        _renderViewChild(Icons.cloud, "value", "subValue"),
                        _renderViewChild(Icons.rowing, "value", "subValue"),
                        _renderViewChild(Icons.water_drop, "value", "subValue"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(AppLocalizations.of(context)!.translate("home_sevenDay"),
                    style: StyleTextConstant.styleText7Day),
              ),
            ),
            ListWeather(),
            ChangeLanguage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint("DISSSSSSS");
    super.dispose();
  }
}
