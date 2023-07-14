import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/screens/home/widgets/actual_weather_animation.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../weather_notifier.dart';

class CurrentWeatherByHour extends ConsumerWidget {
  const CurrentWeatherByHour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List temperaturesByHourByDay =
        ref.watch(weatherProvider).temperatureByHourByDay;
    ScrollController scrollController =
        ref.watch(weatherProvider).scrollController;
    dynamic currentHour =
        ref.watch(weatherProvider).currentWeather['currentHour'];
    bool isLoading = ref.watch(weatherProvider).loading;

    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hoy',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '7 dias >',
                style: TextStyle(
                  color: Color.fromARGB(150, 248, 248, 248),
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                24,
                (index) {
                  String dateString = index < temperaturesByHourByDay.length
                      ? temperaturesByHourByDay[index]['day']
                      : "2023-07-13T09:00";
                  DateTime dateTime = DateTime.parse(dateString);

                  String hour =
                      DateFormat('hh:mm a').format(dateTime).toString();
                  String hourInt = DateFormat('HH').format(dateTime);
                  return (currentHour.toString() == hourInt
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.18,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color:
                                  isLoading ? Colors.transparent : Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(41, 255, 255, 255))),
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          index < temperaturesByHourByDay.length
                                              ? temperaturesByHourByDay[index]
                                                      ['temperature'] +
                                                  "°C"
                                              : "°C",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      ActualWeatherAnimation(
                                        isDay: temperaturesByHourByDay[index]
                                            ["isDay"],
                                        weatherCode:
                                            temperaturesByHourByDay[index]
                                                ["weatherCode"],
                                        size: 40,
                                      ),
                                      /*  Lottie.asset(
                                          "assets/animations/35627-weather-day-clear-sky.json",
                                          width: 40,
                                          height: 40), */
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          index < temperaturesByHourByDay.length
                                              ? hour
                                              : " ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ]),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.18,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(41, 255, 255, 255))),
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          index < temperaturesByHourByDay.length
                                              ? temperaturesByHourByDay[index]
                                                      ['temperature'] +
                                                  "°C"
                                              : "°C",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ActualWeatherAnimation(
                                          isDay: temperaturesByHourByDay[index]
                                              ["isDay"],
                                          weatherCode:
                                              temperaturesByHourByDay[index]
                                                  ["weatherCode"],
                                          size: 40),
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          index < temperaturesByHourByDay.length
                                              ? hour
                                              : " ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ]),
                        ));
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
