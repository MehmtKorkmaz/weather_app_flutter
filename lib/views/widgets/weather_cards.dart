import 'package:flutter/material.dart';
import 'package:weatherappchallenge/base/utils.dart';
import 'package:weatherappchallenge/model/weather_model.dart';
import 'package:weatherappchallenge/views/widgets/animated_weather_icon.dart';

class WeatherCard extends StatefulWidget {
  final List<WeatherModel> weatherList;
  const WeatherCard({super.key, required this.weatherList});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends Utils<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    List<WeatherModel> weatherList = widget.weatherList;
    return Container(
        height: dynamicHeight(0.2),
        width: dynamicWidth(0.95),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.34)),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: dynamicHeight(0.03),
              width: dynamicWidth(0.18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    formattedDateForDailyCards(weatherList[index + 1].date),
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: WeatherIcon(
                      icon: weatherList[index + 1].icon.toString(),
                    ),
                  ),
                  Text(
                    '${weatherList[index + 1].degree.toString()}°C',
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    '${weatherList[index + 1].windSpeed.toString()}km/h',
                    style: theme.textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
