import 'package:uuid/uuid.dart';

class CityModel {
  String id = "";
  final String nameCity;
  final String nameCitySlug;

  CityModel({required this.nameCity, required this.nameCitySlug}) {
    this.id = Uuid().v4();
  }

  CityModel.fromDb({required this.id, required this.nameCity, required this.nameCitySlug}) {}

  Map<String, dynamic> toMap() {
    return {'id': id, 'name_city': nameCity, 'name_city_slug': nameCitySlug};
  }

  @override
  String toString() {
    return 'CityModel{id: $id, name_city: $nameCity, name_city_slug: $nameCitySlug}';
  }
}
