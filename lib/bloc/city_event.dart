import 'package:equatable/equatable.dart';
import 'package:flutter_weather/model/city_model.dart';

abstract class CityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddNewCityEvent extends CityEvent {
  final CityModel cityModel;

  AddNewCityEvent(this.cityModel);

  @override
  List<Object?> get props => [cityModel];
}

class LoadCitiesFromDB extends CityEvent {}

class RemoveCityEvent extends CityEvent {
  final String idCityModel;

  RemoveCityEvent(this.idCityModel);

  @override
  List<Object?> get props => [idCityModel];
}

class GetListCitiesEvent extends CityEvent {}

class ChangeCurrentCityEvent extends CityEvent {
  final CityModel cityModel;

  ChangeCurrentCityEvent(this.cityModel);

  @override
  List<Object?> get props => [cityModel];
}
