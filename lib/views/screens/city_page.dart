import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherappchallenge/base/utils.dart';
import 'package:weatherappchallenge/model/weather_model.dart';
import 'package:weatherappchallenge/views/widgets/information_icons.dart';
import 'package:weatherappchallenge/views/widgets/weather_cards.dart';

class CityPage extends StatefulWidget {
  final List<WeatherModel> weatherList;
  const CityPage({super.key, required this.weatherList});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends Utils<CityPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<WeatherModel> weatherList = widget.weatherList;
    // first object of this list is contains current day's data
    WeatherModel currentWeather = weatherList[0];

    return Stack(
      children: [
        //Backround image
        Opacity(
          opacity: 0.65,
          child: SizedBox(
              height: dynamicHeight(1),
              width: dynamicWidth(1),
              //with this operator if we have no photo of city background changes
              child: (cityPhotoList.contains(currentWeather.city))
                  ? getBackgroundImage(currentWeather.city)
                  : Container()),
        ),
        Scaffold(
          //with this operator if we have no photo of city background changes
          backgroundColor: (cityPhotoList.contains(currentWeather.city))
              ? Colors.transparent
              : theme.scaffoldBackgroundColor,
          appBar: AppBar(
            //City name and location icon
            title: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    currentWeather.city,
                    style: theme.textTheme.headlineSmall,
                  ),
                )
              ],
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                  formattedDateForHeadline(currentWeather.date),
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  'Updated as of ${formattedHour(currentWeather.date)}',
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(
                  height: dynamicHeight(0.05),
                ),
                SizedBox(
                  height: dynamicHeight(0.1),
                  child: Lottie.asset(
                    'assets/icons/${currentWeather.icon}.json',
                    animate: true,
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  currentWeather.weather,
                  style: theme.textTheme.displayMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentWeather.degree.toString(),
                      style: theme.textTheme.displayLarge,
                    ),
                    Text(
                      "°C",
                      style: theme.textTheme.headlineLarge!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: dynamicHeight(0.08),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InformationIcons(
                        icon: "humidity_icon",
                        infoText: '%${currentWeather.humidity.toString()}',
                        headText: 'HUMİDİTY'),
                    InformationIcons(
                        icon: "wind_icon",
                        infoText: '${currentWeather.windSpeed.toString()}km/h',
                        headText: 'WİND'),
                    InformationIcons(
                        icon: "feelslie_icon",
                        infoText: '${currentWeather.feelsLike.toString()}°C',
                        headText: 'FEELS LİKE'),
                  ],
                ),
                WeatherCard(
                  weatherList: weatherList,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
