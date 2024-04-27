import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherappchallenge/base/shared_enums.dart';
import 'dart:convert';

import 'package:weatherappchallenge/controller/shared_manager.dart';
import 'package:weatherappchallenge/model/weather_model.dart';

class ProviderManager extends ChangeNotifier {
  List<String> cityList = [];

  String url(String city) =>
      'https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=75bbece187da05fa4343b25bdb8521fb&units=metric';

  void initCityList() async {
    cityList = await SharedManager.getStringList(SharedEnum.cityList);
    notifyListeners();
    print('cityList' + cityList.toString());
  }

  void addNewCity(String city, BuildContext context) async {
    var data = await http.get(Uri.parse(url(city)));

    if (city.isEmpty) {
      snackBar(context, "Please enter a city name.");
    }
    if (data.statusCode == 200) {
      if (cityList.contains(city)) {
        snackBar(context, "City already in list.");
      } else {
        Map<String, dynamic> parsedData = jsonDecode(data.body);

        cityList.add(parsedData["city"]["name"]);
        SharedManager.setStringList(SharedEnum.cityList, cityList);
      }
    } else {
      snackBar(context, "Something went wrong please try again.");
    }

    notifyListeners();
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

  void deleteCity(String city) {
    cityList.remove(city);
    SharedManager.setStringList(SharedEnum.cityList, cityList);

    notifyListeners();
  }

  void snackBar(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Something went wrong'),
              content: Text(content),
            ));
  }
}
