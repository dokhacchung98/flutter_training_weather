import 'package:flutter/widgets.dart';
import 'package:flutter_weather/model/city_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class CityRepository {
  void openDatabaseCity();

  Future<void> insertCityToTable(CityModel cityModel);

  Future<List<CityModel>?> getListCityFromDB();

  Future removeCityFromDB(String id);

  Future<String?> getCurrentCityId();

  Future saveCurrentCityId(String id);
}

class CityRepositoryImpl implements CityRepository {
  late Database _database;
  static final String keySaveCurrentCityId = "keySaveCurrentCityId";
  SharedPreferences? prefs;

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
        cityModel.toJson(),
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
        return CityModel.fromJson(maps[i]);
      });
    } catch (err) {
      debugPrint('CityRepositoryImpl getListCityFromDB error $err');
      this.closeDatabase();
      return null;
    }
  }

  Future removeCityFromDB(String id) async {
    try {
      await this.openDatabaseCity();
      await _database.rawDelete('DELETE FROM CityTable WHERE id = ?', [id]);
      this.closeDatabase();
    } catch (err) {
      debugPrint("CityRepositoryImpl removeCityFromDB err $err");
      this.closeDatabase();
    }
  }

  Future<String?> getCurrentCityId() async {
    try {
      if (prefs == null) {
        prefs = await SharedPreferences.getInstance();
      }
      String? myCurrentCityId = prefs!.getString(keySaveCurrentCityId);
      return myCurrentCityId;
    } catch (err) {
      debugPrint("CityRepositoryImpl getCurrentCityId err $err");
    }
  }

  Future saveCurrentCityId(String id) async {
    try {
      if (prefs == null) {
        prefs = await SharedPreferences.getInstance();
      }
      await prefs!.setString(keySaveCurrentCityId, id);
    } catch (err) {
      debugPrint("CityRepositoryImpl saveCurrentCityId err $err");
    }
  }

  void closeDatabase() {
    _database.close();
  }
}
