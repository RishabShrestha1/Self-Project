import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String latitude = '';
  String longitude = '';
  PermissionStatus _status = PermissionStatus.denied;
  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
    enterdLocation();
    _requestPermission();
    getLocation();
    getCurrentLocationWeather();
    // mygpsloco();
  }

//Ask permission
  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.location.request();
    setState(() {
      _status = status;
    });
  }

//Get Geo Data
  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      log('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocationWeather() async {
    getLocation().then((value) {
      setState(() {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
      });
      log('Latitude: $latitude, Longitude: $longitude');
    });
    WeatherDataFromApi weatherData =
        await _weatherDataController.getWeatherData("$latitude,$longitude");
    setState(() {
      latitude;
      longitude;
      _weatherData = weatherData;
    });
  }

//Get GPS LOCO WEATHER

//LOo dara from device
  Future<void> enterdLocation() async {
    String enteredLocation = await EnteredLocation.getEnteredLocation();
    setState(() {
      _cityController.text = enteredLocation;
    });
  }

  void onGetWeatherPressed(String LocationalData) async {
    EnteredLocation.setEnteredLocation(LocationalData);
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
      if (_weatherData != null) {
        log(_weatherData.toString());
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                'Welcome to Weather App',
                style: TextStyle(fontSize: 20),
              ),
              //Display Weather Data
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: FutureBuilder<WeatherDataFromApi>(
                  future: buttonPressed
                      ? _weatherDataController
                          .getWeatherData(_cityController.text)
                      : _weatherDataController
                          .getWeatherData("$latitude,$longitude"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      WeatherDataFromApi weatherData = snapshot.data!;
                      return Column(
                        children: [
                          buttonPressed == false
                              ? const Text("The Weather for Current Location")
                              : const Text("The Weather for Entered Location"),
                          Image(
                            image: NetworkImage(
                                'https:${weatherData.current.condition.icon}',
                                scale: 0.5),
                          ),
                          Text('Location: ${weatherData.location.name}'),
                          Text('Temperature: ${weatherData.current.tempC}'),
                          Text(
                              'Condition: ${weatherData.current.condition.text}'),
                        ],
                      );
                    } else {
                      return const Text('No Data');
                    }
                  },
                ),
              ),
              //TextFormField
              Padding(
                padding: const EdgeInsets.fromLTRB(80.0, 30, 80, 0),
                child: Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      hintText: 'Enter City Name',
                      fillColor: Color.fromARGB(255, 250, 230, 198),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2,
                          )),
                    ),
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
                        buttonPressed = true;
                        onGetWeatherPressed(_cityController.text);
                      },
                      child: const Text('Get Weather'),
                    ),
                    //Current Location
                    ElevatedButton(
                      onPressed: () {
                        buttonPressed = false;
                        getCurrentLocationWeather();
                      },
                      child: const Text('Use Current Location'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
