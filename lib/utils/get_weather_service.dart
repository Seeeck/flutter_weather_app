import 'dart:convert';

import 'package:flutter_weather_app/models/weather_response.dart';
import 'package:http/http.dart' as http;

Future<WeatherResponse> getWeatherService(
    double latitude, double longitude) async {
  var url = Uri.https('api.open-meteo.com', 'v1/forecast', {
    "latitude": latitude.toString(),
    "longitude": longitude.toString(),
    "hourly": "temperature_2m",
    "current_weather": "true",
    "timezone": "auto"
  });
  var response = await http.get(url);

  WeatherResponse weatherResponse =
      WeatherResponse.fromJson(jsonDecode(response.body));
  return weatherResponse;
}
