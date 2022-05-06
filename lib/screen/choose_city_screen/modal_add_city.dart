import 'package:flutter/material.dart';
import 'package:flutter_weather/localization/app_localizations.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:slugify/slugify.dart';

class ModalAddCity extends StatefulWidget {
  ModalAddCity({Key? key, required this.listCityExist, this.reloadListCity})
      : super(key: key);

  final List<CityModel> listCityExist;
  VoidCallback? reloadListCity;

  @override
  State<ModalAddCity> createState() => _ModalAddCityState();
}

class _ModalAddCityState extends State<ModalAddCity> {
  final myController = TextEditingController();
  String _messageOfError = "";

  _handleAddNewCity() {
    var _valueOfCity = slugify(myController.text);
    if (_valueOfCity.isEmpty) {
      setState(() {
        _messageOfError = AppLocalizations.of(context)!
            .translate("chooseCity_error_cityRequired");
      });
      return;
    }
    if (_checkCityIsExist(_valueOfCity)) {
      setState(() {
        _messageOfError = AppLocalizations.of(context)!
            .translate("chooseCity_error_cityUnique");
      });
      return;
    }

    if (widget.reloadListCity != null) {
      widget.reloadListCity!();
    }
    setState(() {
      _messageOfError = "";
    });
    Navigator.pop(context);
  }

  bool _checkCityIsExist(String cityName) {
    return widget.listCityExist
        .every((element) => element.nameCitySlug == cityName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 200,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.translate("chooseCity_enterCity"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ha noi...',
                    errorText: _messageOfError.isEmpty ? null : _messageOfError,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: Text(
                          AppLocalizations.of(context)!.translate("cancel")),
                      onPressed: () => Navigator.pop(context),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey))),
                  ElevatedButton(
                    child:
                        Text(AppLocalizations.of(context)!.translate("accept")),
                    onPressed: _handleAddNewCity,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
