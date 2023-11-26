import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherappchallenge/controller/controller.dart';

abstract class Utils<T extends StatefulWidget> extends State<T> {
  Controller controller = Get.put(Controller());

  ThemeData get themeData => Theme.of(context);

  double dynamicHeight(double value) =>
      MediaQuery.of(context).size.height * value;
  double dynamicWidth(double value) =>
      MediaQuery.of(context).size.width * value;

  ThemeData get theme => Theme.of(context);
  String formattedDateForHeadline(String date) =>
      DateFormat('MMMM dd').format(DateTime.parse(date));

  String formattedDateForDailyCards(String date) =>
      DateFormat('EEE dd').format(DateTime.parse(date));
  String formattedHour(String date) =>
      DateFormat('hh:mm a').format(DateTime.parse(date));

  Image getBackgroundImage(String city) => Image.asset(
        'assets/images/${city}.png',
        fit: BoxFit.cover,
      );

  initCityList() {
    controller.cityList = controller.storage.read("cityList");
  }
}
