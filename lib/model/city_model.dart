import 'package:uuid/uuid.dart';

class CityModel {
  CityModel({
    this.nameCity,
    this.nameCitySlug,
  }) {
    this.id = Uuid().v4();
  }

  CityModel.fromJson(dynamic json) {
    id = json['id'];
    nameCity = json['name_city'];
    nameCitySlug = json['name_city_slug'];
  }

  late String id;
  String? nameCity;
  String? nameCitySlug;

  CityModel copyWith({
    String? nameCity,
    String? nameCitySlug,
  }) =>
      CityModel(
        nameCity: nameCity ?? this.nameCity,
        nameCitySlug: nameCitySlug ?? this.nameCitySlug,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_city'] = nameCity;
    map['name_city_slug'] = nameCitySlug;
    return map;
  }
}
