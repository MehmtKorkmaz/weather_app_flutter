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
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.34)),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.width * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    formattedDateForDailyCards(weatherList[index].date),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: WeatherIcon(
                      icon: weatherList[index].icon.toString(),
                    ),
                  ),
                  Text(
                    '${weatherList[index].degree.toString()}°C',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${weatherList[index].windSpeed.toString()}km/h',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
