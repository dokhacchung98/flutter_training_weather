import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/city_event.dart';
import 'package:flutter_weather/bloc/city_state.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:flutter_weather/repository/city_repository.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository? cityRepository;

  CityBloc(this.cityRepository) : super(InitialCityState()) {
    on<LoadCitiesFromDB>(_onLoadCitiesFromDB);
    on<AddNewCityEvent>(_onAddNewCityEvent);
    on<RemoveCityEvent>(_onRemoveCityEvent);
    on<ChangeCurrentCityEvent>(_onChangeCurrentCity);
  }

  Future _onAddNewCityEvent(
      AddNewCityEvent cityEvent, Emitter<CityState> emitter) async {
    List<CityModel> oldListCities = [...state.listCityModels];
    oldListCities.add(cityEvent.cityModel);
    if (cityRepository != null) {
      await cityRepository!.insertCityToTable(cityEvent.cityModel);
    }
    emitter(ChangeListCitiesOrCurrentCityState(
        state.currentCityModel, oldListCities));
  }

  Future _onRemoveCityEvent(
      RemoveCityEvent event, Emitter<CityState> emitter) async {
    List<CityModel> oldListCities = [...state.listCityModels];
    List<CityModel> newListCities = oldListCities
        .where((element) => element.id != event.idCityModel)
        .toList();
    if (cityRepository != null) {
      await cityRepository!.removeCityFromDB(event.idCityModel);
    }
    emitter(ChangeListCitiesOrCurrentCityState(
        state.currentCityModel, newListCities));
  }

  Future _onLoadCitiesFromDB(
      LoadCitiesFromDB event, Emitter<CityState> emitter) async {
    if (cityRepository != null) {
      List<CityModel>? listCities = await cityRepository!.getListCityFromDB();
      String? currentCityId = await cityRepository!.getCurrentCityId();
      if (listCities != null && listCities.length > 0) {
        CityModel? currentCity;
        if (currentCityId != null) {
          currentCity =
              listCities.firstWhere((element) => element.id == currentCityId);
        }
        if (currentCity == null) {
          currentCity = listCities[0];
        }
        await cityRepository!.saveCurrentCityId(currentCity.id);
        emitter(ChangeListCitiesOrCurrentCityState(currentCity, listCities));
      } else {
        CityModel cityModel =
            CityModel(nameCity: 'Hà Nội', nameCitySlug: 'ha-noi');
        await cityRepository!.insertCityToTable(cityModel);
        await cityRepository!.saveCurrentCityId(cityModel.id);
        emitter(ChangeListCitiesOrCurrentCityState(cityModel, [cityModel]));
      }
    }
  }

  void _onChangeCurrentCity(
      ChangeCurrentCityEvent event, Emitter<CityState> emitter) {
    emitter(ChangeListCitiesOrCurrentCityState(
        event.cityModel, state.listCityModels));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
