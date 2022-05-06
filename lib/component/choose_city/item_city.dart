import 'package:flutter/material.dart';
import 'package:flutter_weather/common/style_text.dart';
import 'package:flutter_weather/model/city_model.dart';

class ItemCity extends StatelessWidget {
  ItemCity(
      {Key? key,
      required this.cityModel,
      required this.index,
      this.reloadListCity})
      : super(key: key);

  final CityModel cityModel;
  final int index;
  VoidCallback? reloadListCity;

  _handleRemoveItem() {
    if (reloadListCity != null) {
      reloadListCity!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 128,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://picsum.photos/600/200?random=$index')),
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
              cityModel.nameCity,
              style: StyleTextConstant.styleTextCityLarge,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: _handleRemoveItem,
            icon: Icon(
              Icons.restore_from_trash,
              color: Colors.redAccent,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
