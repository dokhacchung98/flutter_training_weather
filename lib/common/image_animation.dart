import 'package:flutter/material.dart';
import 'package:flutter_weather/common/resource_img_constant.dart';

class ImageAnimation {
  static String mapBackground(String? type) {
    switch (type) {
      case '01d':
        return ResourceImgConstant.imgDayClearSky;
      case '01n':
        return ResourceImgConstant.imgNightClearSky;
      case '02d':
        return ResourceImgConstant.imgDayPartlyCloudy;
      case '02n':
        return ResourceImgConstant.imgNightPartlyCloudy;
      case '03d':
        return ResourceImgConstant.imgDayCloudy;
      case '03n':
        return ResourceImgConstant.imgNightCloudy;
      case '04d':
        return ResourceImgConstant.imgDayCloudy;
      case '04n':
        return ResourceImgConstant.imgNightCloudy;
      case '09d':
        return ResourceImgConstant.imgDayRain;
      case '09n':
        return ResourceImgConstant.imgNightRain;
      case '10d':
        return ResourceImgConstant.imgDayRain;
      case '10n':
        return ResourceImgConstant.imgNightRain;
      case '11d':
        return ResourceImgConstant.imgDayRain;
      case '11n':
        return ResourceImgConstant.imgNightRain;
      case '13d':
        return ResourceImgConstant.imgDaySnow;
      case '13n':
        return ResourceImgConstant.imgNightSnow;
      case '50d':
        return ResourceImgConstant.imgDayFog;
      case '50n':
        return ResourceImgConstant.imgDayFog;
      default:
        return ResourceImgConstant.imgDayClearSky;
    }
  }

  static String mapBackgroundChild(String? type) {
    switch (type) {
      case '01d':
        return ResourceImgConstant.imgDayClearSky24;
      case '01n':
        return ResourceImgConstant.imgNightClearSky24;
      case '02d':
        return ResourceImgConstant.imgDayPartlyCloud24;
      case '02n':
        return ResourceImgConstant.imgNightPartlyCloudy24;
      case '03d':
        return ResourceImgConstant.imgDayCloudy24;
      case '03n':
        return ResourceImgConstant.imgNightCloudy24;
      case '04d':
        return ResourceImgConstant.imgDayCloudy24;
      case '04n':
        return ResourceImgConstant.imgNightCloudy24;
      case '09d':
        return ResourceImgConstant.imgDayRain24;
      case '09n':
        return ResourceImgConstant.imgNightRain24;
      case '10d':
        return ResourceImgConstant.imgDayRain24;
      case '10n':
        return ResourceImgConstant.imgNightRain24;
      case '11d':
        return ResourceImgConstant.imgDayRain24;
      case '11n':
        return ResourceImgConstant.imgNightRain24;
      case '13d':
        return ResourceImgConstant.imgDaySnow24;
      case '13n':
        return ResourceImgConstant.imgNightSnow24;
      case '50d':
        return ResourceImgConstant.imgDayFog24;
      case '50n':
        return ResourceImgConstant.imgDayFog24;
      default:
        return ResourceImgConstant.imgDayClearSky24;
    }
  }

  static String mapNameIcon(String? type) {
    switch (type) {
      case '01d':
        return 'sunny';
      case '01n':
        return 'moon';
      case '02d':
        return 'sunny_cloud';
      case '02n':
        return 'moon_cloud';
      case '03d':
        return 'sunny_cloud2';
      case '03n':
        return 'moon_cloud2';
      case '04d':
        return 'sunny_cloud2';
      case '04n':
        return 'moon_cloud2';
      case '09d':
        return 'sunny_rain';
      case '09n':
        return 'moon_rain';
      case '10d':
        return 'sunny_rain';
      case '10n':
        return 'moon_rain';
      case '11d':
        return 'sunny_rain';
      case '11n':
        return 'moon_rain';
      case '13d':
        return 'sunny_snow';
      case '13n':
        return 'moon_snow';
      case '50d':
        return 'sunny_frog';
      case '50n':
        return 'moon_frog';
      default:
        return 'sunny';
    }
  }
}
