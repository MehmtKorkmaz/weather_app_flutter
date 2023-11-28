import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weatherappchallenge/model/weather_model.dart';
import 'package:get_storage/get_storage.dart';

class Controller extends GetxController {
  String url(String city) =>
      'https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=75bbece187da05fa4343b25bdb8521fb&units=metric';

  List cityList = ['Istanbul', 'Rome'].obs;

  GetStorage storage = GetStorage();

  void addNewCity(String city) async {
    var data = await http.get(Uri.parse(url(city)));

    if (city.isEmpty) {
      Get.snackbar("Oops!", "Please enter a city name.");
    }
    if (data.statusCode == 200) {
      if (cityList.contains(city)) {
        Get.snackbar("Oops!", "City already in list.");
      } else {
        Map<String, dynamic> parsedData = jsonDecode(data.body);

        cityList.add(parsedData["city"]["name"]);
        storage.write("cityList", cityList);
      }
    } else {
      Get.snackbar("Oops!", "Something went wrong please try again.");
    }
  }

  void deleteCity(String city) {
    cityList.remove(city);
    storage.write("cityList", cityList);
  }

  void loadCityList() {
    cityList = storage.read("cityList");
  }

  Future getData(String city) async {
    var data = await http.get(Uri.parse(url(city)));
    if (data.statusCode == 200) {
      Map<String, dynamic> parsedData = jsonDecode(data.body);

      return parsedData;
    }
  }

  Future<List<WeatherModel>> dataToWeatherModel(String city) async {
    Map<String, dynamic> dataAsMap = await getData(city);
    List dataList = dataAsMap["list"];
    List<WeatherModel> weatherList = [];
    String cityName = dataAsMap["city"]["name"];

    for (int i = 0; i < 40; i += 8) {
      WeatherModel weather = WeatherModel.fromJson(dataList[i], cityName);
      weatherList.add(weather);
    }

    return weatherList;
  }
}
