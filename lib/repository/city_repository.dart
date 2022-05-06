import 'package:flutter/widgets.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class CityRepository {
  void openDatabaseCity();
}

class CityRepositoryImpl implements CityRepository {
  late Database _database;

  Future<void> openDatabaseCity() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'city_database.db');
      _database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE CityTable (id TEXT PRIMARY KEY, name_city TEXT, name_city_slug TEXT)');
      });
    } catch (err) {
      debugPrint('CityRepositoryImpl openDatabaseCity error $err');
    }
  }

  Future<void> insertCityToTable(CityModel cityModel) async {
    await this.openDatabaseCity();
    try {
      await _database.insert(
        'CityTable',
        cityModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (err) {
      debugPrint('CityRepositoryImpl insertCityToTable error $err');
    }
  }

  Future<List<CityModel>?> getListCityFromDB() async {
    try {
      await this.openDatabaseCity();
      final List<Map<String, dynamic>> maps =
          await _database.query('CityTable');
      this.closeDatabase();
      return List.generate(maps.length, (i) {
        return CityModel.fromDb(
          id: maps[i]['id'],
          nameCity: maps[i]['name_city'],
          nameCitySlug: maps[i]['name_city_slug']
        );
      });
    } catch (err) {
      debugPrint('CityRepositoryImpl getListCityFromDB error $err');
      this.closeDatabase();
      return null;
    }
  }

  void closeDatabase() {
    _database.close();
  }
}
