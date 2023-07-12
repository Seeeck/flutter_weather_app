import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/screens/home/ActualWeather/actual_weather.dart';
import 'package:flutter_weather_app/screens/home/weather_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Function getCurrentLocation = ref.read(weatherProvider).getCurrentLocation;
    getCurrentLocation();

    Future<void> handleRefresh() async {
      getCurrentLocation();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 9, 24, 1),
        body: RefreshIndicator(
          onRefresh: () => getCurrentLocation(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [ActualWeather(), CurrentWeatherByHour()],
                )),
          ),
        ),
      ),
    );
  }
}

class CurrentWeatherByHour extends StatelessWidget {
  const CurrentWeatherByHour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(children: [
        Row(
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
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                23,
                (index) => Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1, color: Color.fromARGB(41, 255, 255, 255))),
                  child: Column(children: [
                    Text(
                      "23",
                      style: TextStyle(color: Colors.white),
                    ),
                    FlutterLogo(
                      size: 30,
                    ),
                    Text("10:00", style: TextStyle(color: Colors.white))
                  ]),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class DuringTheDay extends StatelessWidget {
  const DuringTheDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      color: Colors.transparent,
    ));
  }
}
