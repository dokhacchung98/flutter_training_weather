import 'package:equatable/equatable.dart';
import 'package:flutter_weather/common/image_animation.dart';
import 'package:flutter_weather/common/resource_img_constant.dart';
import 'package:flutter_weather/model/current_weather_model.dart';

abstract class WeatherState extends Equatable {
  final CurrentWeatherModel weatherModel;
  final String errorMessage;
  final bool isLoading;
  String sourceImageBackground = ResourceImgConstant.imgDayClearSky;
  String nameOfAnim = "sunny";

  WeatherState(this.weatherModel, this.errorMessage, this.isLoading) {
    if (weatherModel.weather != null && weatherModel.weather!.length > 0) {
      nameOfAnim = ImageAnimation.mapNameIcon(weatherModel.weather![0].icon!);
      sourceImageBackground =
          ImageAnimation.mapBackground(weatherModel.weather![0].icon!);
    }
  }

  @override
  List<Object?> get props => [weatherModel, errorMessage, isLoading];
}

class FetchingWeatherState extends WeatherState {
  FetchingWeatherState() : super(CurrentWeatherModel(), '', true);
}

class WeatherFetchSuccessState extends WeatherState {
  WeatherFetchSuccessState(CurrentWeatherModel weatherModel)
      : super(weatherModel, '', false);
}

class WeatherFetchErrorState extends WeatherState {
  WeatherFetchErrorState(String messageError)
      : super(CurrentWeatherModel(), messageError, false);
}
