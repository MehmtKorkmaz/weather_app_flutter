import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:weatherappchallenge/base/utils.dart';
import 'package:weatherappchallenge/controller/service.dart';
import 'package:weatherappchallenge/model/weather_model.dart';
import 'package:weatherappchallenge/views/widgets/animated_weather_icon.dart';

class CityCard extends StatefulWidget {
  final WeatherModel weatherData;
  const CityCard({super.key, required this.weatherData});

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends Utils<CityCard> {
  void deleteCity() {
    context.read<ProviderManager>().deleteCity(widget.weatherData.city);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(15),
            onPressed: (_) {
              deleteCity();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: const Color(0xB2AAA5A5),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          widget.weatherData.city,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        widget.weatherData.weather,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            'Humidity',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            ' ${widget.weatherData.humidity}%',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Wind',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            ' ${widget.weatherData.windSpeed}km/h',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(icon: widget.weatherData.icon),
                      SizedBox(
                        height: dynamicHeight(0.02),
                      ),
                      Text(
                        '${widget.weatherData.degree} °C',
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
