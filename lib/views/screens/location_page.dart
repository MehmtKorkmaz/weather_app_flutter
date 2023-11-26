import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappchallenge/base/utils.dart';
import 'package:weatherappchallenge/controller/controller.dart';
import 'package:weatherappchallenge/model/weather_model.dart';
import 'package:weatherappchallenge/views/screens/home_page.dart';
import 'package:weatherappchallenge/views/widgets/city_cards.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends Utils<Locations> {
  TextEditingController cityController = TextEditingController();
  @override
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Saved Locations',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: dynamicWidth(0.75),
              child: TextField(
                controller: cityController,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add_location,
                color: Colors.white,
              ),
              onPressed: () {
                controller.addNewCity(cityController.text);
                cityController.clear();
              },
            )
          ],
        ),
        body: Obx(
          () => ListView.builder(
              itemCount: controller.cityList.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: controller
                        .dataToWeatherModel(controller.cityList[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      List<WeatherModel>? weatherList = snapshot.data;
                      WeatherModel currentWeather = weatherList![0];

                      return GestureDetector(
                          onTap: () {
                            Get.to(HomePage(weatherList: weatherList));
                          },
                          child: CityCard(weatherData: currentWeather));
                    });
              }),
        ));
  }
}
