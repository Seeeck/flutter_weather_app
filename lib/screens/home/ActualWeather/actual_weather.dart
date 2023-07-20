import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/screens/home/ActualWeather/expanded_actual_weather.dart';
import 'package:flutter_weather_app/screens/home/weather_notifier.dart';
import 'package:flutter_weather_app/screens/home/widgets/actual_weather_animation.dart';

class ActualWeather extends ConsumerWidget {
  const ActualWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: AnimatedCurrentWeatherWidget(),
    );
  }
}

class AnimatedCurrentWeatherWidget extends ConsumerWidget {
  const AnimatedCurrentWeatherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedContainer(
            clipBehavior: Clip.antiAlias,
            duration: const Duration(seconds: 1),
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(17, 106, 245, 1),
                      Color.fromRGBO(21, 195, 246, 1)
                    ]),
                borderRadius: BorderRadius.circular(60)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (MediaQuery.of(context).orientation ==
                    Orientation.landscape) {}

                return RefreshIndicator(
                  onRefresh: ref.read(weatherProvider).getCurrentWeatherData,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: constraints.minHeight),
                      child: IntrinsicHeight(child: ExpandedActualWeather()),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.65,
          child: Container(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(9, 63, 142, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
          ),
        )
      ],
    );
  }
}

class AirAndHumidity extends ConsumerWidget {
  const AirAndHumidity({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> currentWeather =
        ref.watch(weatherProvider).currentWeather;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              child: Column(
                children: [
                  const Icon(
                    Icons.wind_power_outlined,
                    color: Color.fromARGB(211, 255, 255, 255),
                    size: 20,
                  ),
                  FittedBox(
                    child: Text(
                      "${currentWeather['windSpeed']} km/h",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  FittedBox(
                    child: const Text('Viento',
                        style: TextStyle(
                            color: Color.fromARGB(171, 255, 255, 255))),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              child: const Column(
                children: [
                  FittedBox(
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Color.fromARGB(211, 255, 255, 255),
                      size: 20,
                    ),
                  ),
                  FittedBox(child: AirDirection()),
                  FittedBox(
                    child: Text(
                      "Direccion del viento",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(171, 255, 255, 255),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CurrentWeatherDate extends ConsumerWidget {
  const CurrentWeatherDate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> currentWeather =
        ref.watch(weatherProvider).currentWeather;
    return FittedBox(
      child: Text(
        currentWeather['currentDay'] +
            " " +
            currentWeather['dayNumber'].toString() +
            " de " +
            currentWeather['monthDay'],
        style: MediaQuery.of(context).orientation == Orientation.portrait
            ? const TextStyle(
                color: Color.fromARGB(171, 255, 255, 255), fontSize: 14)
            : const TextStyle(color: Colors.white, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CurrentTemperature extends ConsumerWidget {
  const CurrentTemperature({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> currentWeather =
        ref.watch(weatherProvider).currentWeather;
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(
          "${currentWeather['temperature']}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 90,
          ),
        ),
      ),
    );
  }
}

class WeatherPrincipalAnimation extends ConsumerWidget {
  const WeatherPrincipalAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(weatherProvider).loading;
    Map<String, dynamic> currentWeather =
        ref.watch(weatherProvider).currentWeather;
    return SizedBox(
      child: isLoading
          ? Container(
              margin: const EdgeInsets.all(50),
              height: 100,
              width: 100,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ActualWeatherAnimation(
              size: 200,
              isDay: currentWeather['isDay'],
              weatherCode: currentWeather['weatherCode'],
            ),
    );
  }
}

class CurrentLocation extends ConsumerWidget {
  const CurrentLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> currentWeather =
        ref.watch(weatherProvider).currentWeather;
    bool isLoading = ref.watch(weatherProvider).loading;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: isLoading
          ? [
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            ]
          : [
              Flexible(
                  child: const Icon(Icons.location_on, color: Colors.white)),
              Flexible(
                child: FittedBox(
                  child: Text(
                    currentWeather['location']!,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
    );
  }
}

class AirDirection extends ConsumerWidget {
  const AirDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic numberDirection =
        ref.watch(weatherProvider).currentWeather['windDirection'];

    String getDirectionText(dynamic numberDirection) {
      if (numberDirection >= 0 && numberDirection < 45) {
        return "Norte";
      } else if (numberDirection >= 45 && numberDirection < 90) {
        return "Noreste";
      } else if (numberDirection >= 90 && numberDirection < 135) {
        return "Este";
      } else if (numberDirection >= 135 && numberDirection < 180) {
        return "Sureste";
      } else if (numberDirection >= 180 && numberDirection < 225) {
        return "Sur";
      } else if (numberDirection >= 225 && numberDirection < 270) {
        return "Suroeste";
      } else if (numberDirection >= 270 && numberDirection < 315) {
        return "Oeste";
      } else if (numberDirection >= 315 && numberDirection < 360) {
        return "Noroeste";
      } else {
        return "Desconocido";
      }
    }

    return Text(
      textAlign: TextAlign.center,
      getDirectionText(numberDirection),
      style: TextStyle(color: Colors.white),
    );
  }
}

class WeatherType extends ConsumerWidget {
  const WeatherType({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> currentWeather =
        ref.watch(weatherProvider).currentWeather;

    if (currentWeather['weatherCode'] == 0) {
      return Container(
        child: Text(
          "Despejado",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 1 ||
        currentWeather['weatherCode'] == 2 ||
        currentWeather['weatherCode'] == 3) {
      return Container(
        child: Text(
          "Nuboso",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 45 ||
        currentWeather['weatherCode'] == 48) {
      return Container(
        child: Text(
          "Neblina",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 56 ||
        currentWeather['weatherCode'] == 57) {
      return Container(
        child: Text(
          "Congelado",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 61) {
      return Container(
        child: Text(
          "Poca lluvia",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 62 ||
        currentWeather['weatherCode'] == 63 ||
        currentWeather['weatherCode'] == 66 ||
        currentWeather['weatherCode'] == 67 ||
        currentWeather['weatherCode'] == 80 ||
        currentWeather['weatherCode'] == 81 ||
        currentWeather['weatherCode'] == 82) {
      return Container(
        child: Text(
          "Lluvioso",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 71 ||
        currentWeather['weatherCode'] == 73 ||
        currentWeather['weatherCode'] == 75 ||
        currentWeather['weatherCode'] == 77 ||
        currentWeather['weatherCode'] == 85 ||
        currentWeather['weatherCode'] == 86) {
      return Container(
        child: Text(
          "Nevado",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }

    if (currentWeather['weatherCode'] == 95 ||
        currentWeather['weatherCode'] == 96 ||
        currentWeather['weatherCode'] == 99) {
      return Container(
        child: Text(
          "Tormenta",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
        ),
      );
    }
    return Container(
      child: Text(
        "Error al obtener tipo de clima",
        style:
            TextStyle(color: Color.fromARGB(255, 252, 251, 251), fontSize: 25),
      ),
    );
  }
}
