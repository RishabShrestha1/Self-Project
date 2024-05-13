import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weatherapp_2024/constants/apiconst.dart';

import 'dart:convert';

import 'package:weatherapp_2024/datasource/FromApi/weatherdatamodel.dart';

class WeatherDataController {
  Future<WeatherDataFromApi> getWeatherData(String city) async {
    ApiConsts apiConsts = ApiConsts();
    String url = apiConsts.baseUrl + city;
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Response: ${response.body}');

      return WeatherDataFromApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
