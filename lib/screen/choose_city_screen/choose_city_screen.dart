import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/city_event.dart';
import 'package:flutter_weather/component/choose_city/item_city.dart';
import 'package:flutter_weather/localization/app_localizations.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:flutter_weather/screen/choose_city_screen/modal_add_city.dart';

class ChooseCityScreen extends StatelessWidget {
  ChooseCityScreen({Key? key}) : super(key: key);
  BuildContext? _buildContext;

  _openModalCreateCity(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return ModalAddCity(
          listCityExist: [],
        );
      },
    );
  }

  _selectCityCurrent(CityModel cityModel) {
    if (_buildContext == null) return;
    final CityBloc _cityBloc = BlocProvider.of<CityBloc>(_buildContext!);
    CityModel currentCityModel = _cityBloc.state.currentCityModel;
    if (cityModel.id != currentCityModel.id) {
      _cityBloc.add(ChangeCurrentCityEvent(cityModel));
    }
    Navigator.pop(_buildContext!);
  }

  @override
  Widget build(BuildContext context) {
    if (_buildContext == null) {
      _buildContext = context;
    }
    final List<CityModel> listCity =
        BlocProvider.of<CityBloc>(context, listen: true).state.listCityModels;
    final CityModel currentCityModel =
        BlocProvider.of<CityBloc>(context, listen: true).state.currentCityModel;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.translate("chooseCity_title")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openModalCreateCity(context),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: listCity.length,
          itemBuilder: (context, index) => ItemCity(
            cityModel: listCity[index],
            index: index,
            callBackSelectCity: _selectCityCurrent,
            currentCityModel: currentCityModel,
          ),
        ),
      ),
    );
  }
}
