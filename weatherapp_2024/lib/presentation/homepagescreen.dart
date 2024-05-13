import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weatherapp_2024/datasource/FromApi/weatherdatacontroller.dart';
import 'package:weatherapp_2024/datasource/FromApi/weatherdatamodel.dart';
import 'package:weatherapp_2024/datasource/localStorage/entered_location.dart';
// import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherDataController _weatherDataController = WeatherDataController();
  WeatherDataFromApi? _weatherData;

  @override
  void initState() {
    super.initState();
    enterLocation();
  }

//LOCo dara from device
  Future<void> enterLocation() async {
    String enteredLocation = await EnteredLocation.getEnteredLocation();
    setState(() {
      _cityController.text = enteredLocation;
    });
  }

  void onGetWeatherPressed(String LocationalData) async {
    EnteredLocation.setEnteredLocation(LocationalData);
    log('Location: $LocationalData');
    try {
      log('Getting Weather Data');
      log(_weatherData.toString());
      WeatherDataFromApi weatherData =
          await _weatherDataController.getWeatherData(LocationalData);
      setState(
        () {
          _weatherData = weatherData;
          log('Weather Data Received');
          log(_weatherData.toString()); // Add this
        },
      );
      // Log specific properties after checking for null
      if (_weatherData != null &&
          _weatherData!.current != null &&
          _weatherData!.current!.tempC != null) {
        log(_weatherData!.current!.tempC.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to Weather App'),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  hintText: 'Enter City Name',
                ),
              ),
            ),
            //Submit button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onGetWeatherPressed(_cityController.text);
                    },
                    child: const Text('Get Weather'),
                  ),
                  //Current Location
                  ElevatedButton(
                    onPressed: () {
                      //Get current location
                    },
                    child: const Text('Use Current Location'),
                  ),
                ],
              ),
            ),
            //Display Weather Data
            if (_weatherData != null)
              Column(
                children: [
                  Text('Location: ${_weatherData!.location!.name}'),
                  Text('Temperature: ${_weatherData!.current!.tempC}'),
                  Text('Condition: ${_weatherData!.current!.condition!.text}'),
                  Image(
                      image: NetworkImage(
                          'https:${_weatherData!.current!.condition!.icon}')),
                ],
              )
            else
              Text('No Data'),
          ],
        ),
      ),
    );
  }
}
