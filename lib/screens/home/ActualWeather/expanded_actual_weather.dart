import 'package:flutter/material.dart';

import 'actual_weather.dart';

class ExpandedActualWeather extends StatelessWidget {
  const ExpandedActualWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(children: [
            Expanded(flex: 2, child: const CurrentLocation()),
            Expanded(flex: 4, child: const WeatherPrincipalAnimation()),
            Expanded(flex: 2, child: const CurrentTemperature()),
            Expanded(flex: 2, child: const WeatherType()),
            Expanded(child: const CurrentWeatherDate()),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Divider(
                  color: Color.fromARGB(157, 255, 255, 255),
                ),
              ),
            ),
            Expanded(flex: 4, child: const AirAndHumidity()),
          ])
        : Column(children: [
            Expanded(flex: 1, child: const CurrentLocation()),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 2,
                      child:
                          Container(child: const WeatherPrincipalAnimation())),
                  Flexible(
                      flex: 7,
                      child: Container(child: const CurrentTemperature())),
                  Flexible(flex: 4, child: const WeatherType())
                ],
              ),
            ),
            Expanded(child: const CurrentWeatherDate()),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Divider(
                  color: Color.fromARGB(157, 255, 255, 255),
                ),
              ),
            ),
            Expanded(flex: 3, child: const AirAndHumidity()),
          ]);
  }
}
