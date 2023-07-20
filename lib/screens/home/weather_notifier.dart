import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/models/weather_response.dart';

import 'package:flutter_weather_app/services/get_current_location_service.dart';
import 'package:flutter_weather_app/services/get_location_name_service.dart';
import 'package:flutter_weather_app/services/get_weather_service.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:geolocator/geolocator.dart';

class WeatherNotifier extends ChangeNotifier {
  BuildContext? context;

  void setContext(BuildContext context) {
    this.context = context;
  }

  ScrollController scrollController = new ScrollController();
  Map<String, dynamic> currentWeather = {
    "temperature": 0,
    "windSpeed": 0,
    "windDirection": 0,
    "weatherCode": 0,
    "isDay": 0,
    "currentDay": "",
    "monthDay": "",
    "dayNumber": 0,
    "location": "",
  };
  List temperatureByHourByDay = [
    {
      "day": '2023-07-13T09:00',
      "temperature": "20",
      "isDay": 0,
      "weatherCode": 0
    },
    {
      "day": '2023-07-13T09:00',
      "temperature": "20",
      "isDay": 0,
      "weatherCode": 0
    },
  ];
  String? location = '';
  bool loading = false;
  bool isWeek = false;

  GlobalKey byHourWidgetKey = new GlobalKey();

  Future<void> getCurrentWeatherData() async {
    loading = true;
    try {
      Position currentPosition = await getCurretLocationService();

      String location = await getLocationNameService(
          currentPosition.latitude, currentPosition.longitude);
      currentWeather['location'] = location;
      WeatherResponse weatherResponse = await getWeatherService(
          currentPosition.latitude, currentPosition.longitude);
      currentWeather['temperature'] =
          weatherResponse.currentWeather.temperature;
      currentWeather['windSpeed'] = weatherResponse.currentWeather.windspeed;
      currentWeather['windDirection'] =
          weatherResponse.currentWeather.winddirection;
      currentWeather['weatherCode'] =
          weatherResponse.currentWeather.weathercode;
      currentWeather['isDay'] = weatherResponse.currentWeather.isDay;
      currentWeather['wheatherByHour'] = weatherResponse.hourly.time;
      currentWeather['wheatherByTemperature'] = weatherResponse
        ..hourlyUnits.temperature2M;
      temperatureByHourByDay = [];

      weatherResponse.hourly.time.forEach((element) {
        temperatureByHourByDay
            .add({"day": element, "temperature": "", "weatherCode": 0});
      });
      for (int index = 0;
          index < weatherResponse.hourly.temperature2M.length;
          index++) {
        temperatureByHourByDay[index]["temperature"] =
            weatherResponse.hourly.temperature2M[index].toString();
        temperatureByHourByDay[index]["weatherCode"] =
            weatherResponse.hourly.weatherCode[index];

        temperatureByHourByDay[index]["isDay"] =
            weatherResponse.hourly.isDay[index];
      }

      String dateStr = weatherResponse.currentWeather.time;
      DateTime dateTime = DateTime.parse(dateStr);

      await initializeDateFormatting(
          'es_ES', null); // Esto inicializa los formatos de fecha en español
      DateFormat dateFormat = DateFormat.EEEE('es_ES');
      DateFormat dateFormatM = DateFormat.MMMM('es_ES');
      String dayName = dateFormat.format(dateTime);
      String monthName = dateFormatM.format(dateTime);
      int dayNumber = dateTime.day;
      currentWeather['currentHour'] = dateTime.hour;
      currentWeather['dayNumber'] = dayNumber;
      currentWeather['currentDay'] = dayName;
      currentWeather['monthDay'] = monthName;
      loading = false;
      notifyListeners();
    } catch (e) {
      throw Exception("holi");
    }
  }

  GlobalKey currentWidgetHourIndexKey = new GlobalKey();
  void scrollToIndex() {
    final context = currentWidgetHourIndexKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          alignment: 0.1,
          curve: Curves.decelerate,
          duration: Duration(seconds: 1));
    }
  }
}

final weatherProvider = ChangeNotifierProvider<WeatherNotifier>((ref) {
  return WeatherNotifier();
});
