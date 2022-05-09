part of 'weather_seven_day_bloc.dart';

abstract class WeatherSevenDayEvent extends Equatable {}

class GetSevenDayWeatherEvent extends WeatherSevenDayEvent {
  final String cityName;
  final String lang;

  GetSevenDayWeatherEvent(this.cityName, this.lang);

  @override
  List<Object?> get props => [cityName, lang];
}
