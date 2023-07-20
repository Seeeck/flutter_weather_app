import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/screens/home/widgets/actual_weather_animation.dart';
import 'package:intl/intl.dart';

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

    GlobalKey currentWidgetHourIndexKey =
        ref.watch(weatherProvider).currentWidgetHourIndexKey;
    int flexTodayWeek = 0;
    int flexWidgetByHour = 0;

    if (MediaQuery.of(context).size.height <= 565) {
      flexTodayWeek = 1;
      flexWidgetByHour = 2;
    } else if (MediaQuery.of(context).size.height <= 900) {
      flexTodayWeek = 1;
      flexWidgetByHour = 1;
    } else {
      flexTodayWeek = 1;
      flexWidgetByHour = 2;
    }
    return SingleChildScrollView(
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

            String hour = DateFormat('hh:mm a').format(dateTime).toString();
            String hourInt = DateFormat('HH').format(dateTime);
            return (LayoutBuilder(builder: (context, constraints) {
              WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => ref.read(weatherProvider).scrollToIndex());
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                key: currentHour.toString() == hourInt
                    ? currentWidgetHourIndexKey
                    : null,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: currentHour.toString() == hourInt
                        ? Colors.blue
                        : Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1, color: Color.fromARGB(41, 255, 255, 255))),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              SizedBox(
                                height: 5,
                              ),
                              ActualWeatherAnimation(
                                  isDay: temperaturesByHourByDay[index]
                                      ["isDay"],
                                  weatherCode: temperaturesByHourByDay[index]
                                      ["weatherCode"],
                                  size: 40),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  index < temperaturesByHourByDay.length
                                      ? hour
                                      : " ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ]);
                      }),
              );
            }));
          },
        ),
      ),
    );
  }
}
