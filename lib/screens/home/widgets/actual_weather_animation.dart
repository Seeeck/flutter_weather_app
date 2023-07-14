import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ActualWeatherAnimation extends ConsumerWidget {
  final int isDay;
  final int weatherCode;
  final double size;

  ActualWeatherAnimation(
      {super.key,
      required this.isDay,
      required this.weatherCode,
      required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isDay == 1) {
      if (weatherCode == 0) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35627-weather-day-clear-sky.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 1 || weatherCode == 2 || weatherCode == 3) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35690-weather-day-broken-clouds.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 45 || weatherCode == 48) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35630-weather-day-few-clouds.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 56 || weatherCode == 57) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35630-weather-day-few-clouds.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 61) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35707-weather-day-shower-rains.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 62 ||
          weatherCode == 63 ||
          weatherCode == 66 ||
          weatherCode == 67 ||
          weatherCode == 80 ||
          weatherCode == 81 ||
          weatherCode == 82) {
        return Container(
          child: Lottie.asset("assets/animations/35724-weather-day-rain.json",
              width: size, height: size),
        );
      }

      if (weatherCode == 71 ||
          weatherCode == 73 ||
          weatherCode == 75 ||
          weatherCode == 77 ||
          weatherCode == 85 ||
          weatherCode == 86) {
        return Container(
          child: Lottie.asset("assets/animations/35743-weather-day-snow.json",
              width: size, height: size),
        );
      }

      if (weatherCode == 95 || weatherCode == 96 || weatherCode == 99) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35733-weather-day-thunderstorm.json",
              width: size,
              height: size),
        );
      }
    }

    if (isDay == 0) {
      if (weatherCode == 0) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35781-weather-night-clear-sky.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 1 || weatherCode == 2 || weatherCode == 3) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35775-weather-night-broken-clouds.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 45 || weatherCode == 48) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35779-weather-night-few-clouds.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 56 || weatherCode == 57) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35779-weather-night-few-clouds.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 61) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35774-weather-night-shower-rains.json",
              width: size,
              height: size),
        );
      }

      if (weatherCode == 62 ||
          weatherCode == 63 ||
          weatherCode == 66 ||
          weatherCode == 67 ||
          weatherCode == 80 ||
          weatherCode == 81 ||
          weatherCode == 82) {
        return Container(
          child: Lottie.asset("assets/animations/35772-weather-night-rain.json",
              width: size, height: size),
        );
      }

      if (weatherCode == 71 ||
          weatherCode == 73 ||
          weatherCode == 75 ||
          weatherCode == 77 ||
          weatherCode == 85 ||
          weatherCode == 86) {
        return Container(
          child: Lottie.asset("assets/animations/35752-weather-night-snow.json",
              width: size, height: size),
        );
      }

      if (weatherCode == 95 || weatherCode == 96 || weatherCode == 99) {
        return Container(
          child: Lottie.asset(
              "assets/animations/35755-weather-night-thunderstorm.json",
              width: size,
              height: size),
        );
      }
    }

    return const Text(
      "No so pudo obtener el tipo de clima",
      style: TextStyle(color: Colors.white),
    );
  }
}
