import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherappchallenge/base/shared_enums.dart';

class SharedManager {
  SharedManager._();

  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setStringList(
      SharedEnum key, List<String> cityList) async {
    return await _sharedPreferences.setStringList(key.name, cityList);
  }

  static Future<List<String>> getStringList(SharedEnum key) async {
    List<String> cityList = [];
    cityList = _sharedPreferences.getStringList(key.name) ?? [];
    return cityList;
  }
}
