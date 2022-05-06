import 'package:flutter/material.dart';
import 'package:flutter_weather/component/choose_city/item_city.dart';
import 'package:flutter_weather/localization/app_localizations.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:flutter_weather/screen/choose_city_screen/modal_add_city.dart';

class ChooseCityScreen extends StatelessWidget {
  ChooseCityScreen({Key? key}) : super(key: key);

  _openModalCreateCity(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalAddCity(
          listCityExist: [],
          reloadListCity: _reloadListCity,
        );
      },
    );
  }

  _reloadListCity() {}

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ItemCity(
              index: 0,
              cityModel: CityModel(nameCitySlug: 'ha-noi', nameCity: "Hà Nội"),
              reloadListCity: _reloadListCity,
            ),
            ItemCity(
              index: 1,
              cityModel: CityModel(
                  nameCitySlug: 'ho-chi-minh', nameCity: "Hồ Chí Minh"),
              reloadListCity: _reloadListCity,
            ),
          ],
        ),
      ),
    );
  }
}
