import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/home/ActualWeather/actual_weather.dart';

class NoExpandedActualWeather extends StatelessWidget {
  const NoExpandedActualWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: CurrentLocation()),
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(flex: 4, child: WeatherPrincipalAnimation()),
          Flexible(
            flex: 6,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Flexible(flex: 1, child: CurrentTemperature()),
              Flexible(flex: 1, child: WeatherType()),
              Flexible(flex: 4, child: CurrentWeatherDate())
            ]),
          ),
        ]),
        AirAndHumidity()
      ],
    );
  }
}
