import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/models/weather_response.dart';
import 'package:flutter_weather_app/utils/get_current_address_service.dart';
import 'package:flutter_weather_app/utils/get_current_location_service.dart';
import 'package:flutter_weather_app/utils/get_weather_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:geolocator/geolocator.dart';

class WeatherNotifier extends ChangeNotifier {
  Map<String, dynamic> currentWeather = {
    "temperature": 0,
    "windSpeed": 0,
    "windDirection": 0,
    "weatherCode": 0,
    "isDay": 0,
    "currentDay": "",
    "monthDay": "",
    "dayNumber": 0
  };

  String? location = '';
  bool loading = false;

  Future<void> getCurrentLocation() async {
    loading = true;

    Position currentPosition = await getCurretLocationService();
    List<Placemark> placemarks = await getCurrentAddressService(
        currentPosition.latitude, currentPosition.longitude);
    location = placemarks.elementAt(1).locality;
    getWeather(currentPosition.latitude, currentPosition.longitude);
  }

  void getWeather(double latitude, double longitude) async {
    WeatherResponse weatherResponse =
        await getWeatherService(latitude, longitude);

    currentWeather['temperature'] = weatherResponse.currentWeather.temperature;
    currentWeather['windSpeed'] = weatherResponse.currentWeather.windspeed;
    currentWeather['windDirection'] =
        weatherResponse.currentWeather.winddirection;
    currentWeather['weatherCode'] = weatherResponse.currentWeather.weathercode;
    currentWeather['isDay'] = weatherResponse.currentWeather.isDay;
    String dateStr = weatherResponse.currentWeather.time;
    DateTime dateTime = DateTime.parse(dateStr);

    await initializeDateFormatting(
        'es_ES', null); // Esto inicializa los formatos de fecha en español
    DateFormat dateFormat = DateFormat.EEEE('es_ES');
    DateFormat dateFormatM = DateFormat.MMMM('es_ES');
    String dayName = dateFormat.format(dateTime);
    String monthName = dateFormatM.format(dateTime);
    int dayNumber = dateTime.day;

    currentWeather['dayNumber'] = dayNumber;
    currentWeather['currentDay'] = dayName;
    currentWeather['monthDay'] = monthName;
    loading = false;
    notifyListeners();
  }
}

final weatherProvider = ChangeNotifierProvider<WeatherNotifier>((ref) {
  return WeatherNotifier();
});
