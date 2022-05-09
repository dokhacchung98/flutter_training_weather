import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/city_event.dart';
import 'package:flutter_weather/common/style_text.dart';
import 'package:flutter_weather/localization/app_localizations.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:slugify/slugify.dart';

class ModalAddCity extends StatefulWidget {
  ModalAddCity({Key? key, required this.listCityExist}) : super(key: key);

  final List<CityModel> listCityExist;

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
    BlocProvider.of<CityBloc>(context).add(AddNewCityEvent(CityModel(
        nameCity: myController.text.trim(), nameCitySlug: _valueOfCity)));

    setState(() {
      _messageOfError = "";
    });
    Navigator.pop(context);
  }

  bool _checkCityIsExist(String cityName) {
    return widget.listCityExist
            .firstWhere((element) => element.nameCitySlug == cityName,
                orElse: () => CityModel())
            .nameCity !=
        null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.translate("chooseCity_enterCity"),
                style: StyleTextConstant.styleTextCitySmall,
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: 'Ha noi...',
                    errorText: _messageOfError.isEmpty ? null : _messageOfError,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        child: Text(
                            AppLocalizations.of(context)!.translate("cancel")),
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey))),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(
                          AppLocalizations.of(context)!.translate("accept")),
                      onPressed: _handleAddNewCity,
                    ),
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
