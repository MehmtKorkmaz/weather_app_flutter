import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappchallenge/base/utils.dart';
import 'package:weatherappchallenge/controller/controller.dart';
import 'package:weatherappchallenge/model/weather_model.dart';
import 'package:weatherappchallenge/views/screens/city_page.dart';
import 'package:weatherappchallenge/views/widgets/city_cards.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends Utils<Locations> {
  TextEditingController cityController = TextEditingController();
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Page name and icon
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

        //Textfield and button for add new city
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: dynamicWidth(0.75),
              child: TextField(
                controller: cityController,
                decoration: InputDecoration(
                    hintText: "Enter a city name",
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            //AddNewCity Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    controller.addNewCity(cityController.text);
                  });
                  cityController.clear();
                },
                child: const CircleAvatar(
                  child: Icon(Icons.add_location_alt_outlined),
                ),
              ),
            ),
          ],
        ),

        //City Card Builder
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
                      //we take 5 day's data as a list
                      List<WeatherModel>? weatherList = snapshot.data;
                      //First object of this list is contains current day's data
                      WeatherModel currentWeather = weatherList![0];

                      return InkWell(
                          onTap: () {
                            Get.to(CityPage(weatherList: weatherList));
                          },
                          child: CityCard(weatherData: currentWeather));
                    });
              }),
        ));
  }
}
