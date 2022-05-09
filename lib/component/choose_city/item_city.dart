import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/city_bloc.dart';
import 'package:flutter_weather/bloc/city_event.dart';
import 'package:flutter_weather/common/style_text.dart';
import 'package:flutter_weather/model/city_model.dart';

typedef CallBackSelectCity = void Function(CityModel);

class ItemCity extends StatelessWidget {
  ItemCity({
    Key? key,
    required this.cityModel,
    required this.index,
    required this.currentCityModel,
    this.callBackSelectCity,
  }) : super(key: key);

  final CityModel cityModel;
  final CityModel currentCityModel;
  final int index;
  final CallBackSelectCity? callBackSelectCity;

  _handleRemoveItem(BuildContext context) {
    BlocProvider.of<CityBloc>(context).add(RemoveCityEvent(cityModel.id));
  }

  _selectTheCity() {
    if (callBackSelectCity != null) {
      callBackSelectCity!(cityModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectTheCity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 128,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage('https://picsum.photos/600/200?random=$index'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                )
              ],
            ),
            padding: EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                cityModel.nameCity ?? '',
                style: StyleTextConstant.styleTextCityLarge,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => _handleRemoveItem(context),
              icon: Icon(
                Icons.restore_from_trash,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
          ),
          if (currentCityModel.nameCitySlug == cityModel.nameCitySlug)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 8, top: 14),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 26,
                ),
              ),
            )
        ],
      ),
    );
  }
}
