import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/screens/home/ActualWeather/actual_weather.dart';
import 'package:flutter_weather_app/screens/home/CurrentWeatherByHour/current_weather_by_hour.dart';
import 'package:flutter_weather_app/screens/home/weather_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(weatherProvider).setContext(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 9, 24, 1),
        body: Column(children: [ActualWeather(), CurrentWeatherByHour()]),
      ),
    );
  }
}
