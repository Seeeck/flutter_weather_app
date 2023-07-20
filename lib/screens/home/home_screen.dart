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
        body: FutureBuilder(
          future: ref.read(weatherProvider).getCurrentWeatherData(),
          builder: (context, snapshot) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                int flexValueActualWeather = 0;
                int flexValueCurrentWeatherByHour = 0;
                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  if (MediaQuery.of(context).size.height <= 667) {
                    flexValueActualWeather = 5;
                    flexValueCurrentWeatherByHour = 2;
                  } else if (MediaQuery.of(context).size.height <= 720) {
                    flexValueActualWeather = 8;
                    flexValueCurrentWeatherByHour = 2;
                  } else if (MediaQuery.of(context).size.height <= 900) {
                    flexValueActualWeather = 9;
                    flexValueCurrentWeatherByHour = 2;
                  } else {
                    flexValueActualWeather = 9;
                    flexValueCurrentWeatherByHour = 2;
                  }
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: flexValueActualWeather,
                          child: ActualWeather(),
                        ),
                        Expanded(flex: 1, child: TodayWeekLabel()),
                        Expanded(
                            flex: flexValueCurrentWeatherByHour,
                            child: CurrentWeatherByHour())
                      ]);
                } else {
                  if (MediaQuery.of(context).size.height <= 667) {
                    flexValueActualWeather = 8;
                    flexValueCurrentWeatherByHour = 3;
                  } else if (MediaQuery.of(context).size.height <= 720) {
                    flexValueActualWeather = 8;
                    flexValueCurrentWeatherByHour = 2;
                  } else if (MediaQuery.of(context).size.height <= 900) {
                    flexValueActualWeather = 9;
                    flexValueCurrentWeatherByHour = 2;
                  } else {
                    flexValueActualWeather = 9;
                    flexValueCurrentWeatherByHour = 2;
                  }

                  if (MediaQuery.of(context).size.height > 320 &&
                      MediaQuery.of(context).size.height <= 666) {
                    flexValueActualWeather = 8;
                    flexValueCurrentWeatherByHour = 4;
                  }

                  if (MediaQuery.of(context).size.height <= 448) {
                    flexValueActualWeather = 8;
                    flexValueCurrentWeatherByHour = 6;
                  }
                  return Column(children: [
                    Flexible(
                        flex: flexValueActualWeather, child: ActualWeather()),
                    Expanded(flex: 1, child: TodayWeekLabel()),
                    Flexible(
                        flex: flexValueCurrentWeatherByHour,
                        child: CurrentWeatherByHour())
                  ]);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class TodayWeekLabel extends StatelessWidget {
  const TodayWeekLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Hoy',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
