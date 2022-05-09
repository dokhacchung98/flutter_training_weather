part of 'weather_seven_day_bloc.dart';

@immutable
abstract class WeatherSevenDayState extends Equatable {}

class WeatherSevenFetching extends WeatherSevenDayState {
  @override
  List<Object?> get props => [];
}

class WeatherSevenDayInitialState extends WeatherSevenDayState {
  final List<WeatherSevenDayModel> listWeatherSevenDays = [];

  WeatherSevenDayInitialState();

  @override
  List<Object?> get props => [listWeatherSevenDays];
}

class WeatherSevenDayFetchSuccessState extends WeatherSevenDayState {
  final List<WeatherSevenDayModel> listWeatherSevenDays;

  WeatherSevenDayFetchSuccessState(this.listWeatherSevenDays);

  @override
  List<Object?> get props => [listWeatherSevenDays];
}

class WeatherSevenDayFetchFaildState extends WeatherSevenDayState {
  final String errorMessage;

  WeatherSevenDayFetchFaildState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
