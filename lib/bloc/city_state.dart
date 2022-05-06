import 'package:equatable/equatable.dart';
import 'package:flutter_weather/model/city_model.dart';

abstract class CityState extends Equatable {
  final CityModel currentCityModel;
  final List<CityModel> listCityModels;

  const CityState(this.currentCityModel, this.listCityModels);

  @override
  List<Object> get props => [currentCityModel, listCityModels];
}

class InitialCityState extends CityState {
  InitialCityState()
      : super(CityModel(nameCity: 'Hà Nội', nameCitySlug: 'ha-noi'), []);

  @override
  String toString() {
    return 'CityState InitialCityState ${currentCityModel} AND ${listCityModels}';
  }
}
