import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class Utils<T extends StatefulWidget> extends State<T> {
  List<String> cityPhotoList = [
    "Rome",
    "Barcelona",
    "New York",
    "Istanbul",
    "Bangkok",
    "Beijig",
    "Dubai",
    "London",
    "Minsk",
    "Paris"
  ];

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

  Image getBackgroundImage(String city) =>
      Image.asset('assets/images/$city.png', fit: BoxFit.cover);
}
