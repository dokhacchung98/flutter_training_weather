import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherStartFetchDataEvent extends WeatherEvent {
  final String country;
  final String lang;

  WeatherStartFetchDataEvent(this.country, this.lang);

  @override
  List<Object?> get props => [country, lang];
}
