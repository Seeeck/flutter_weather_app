import 'dart:convert';

class WeatherResponse {
  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  double elevation;
  CurrentWeather currentWeather;
  HourlyUnits hourlyUnits;
  Hourly hourly;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
    required this.hourlyUnits,
    required this.hourly,
  });

  factory WeatherResponse.fromRawJson(String str) =>
      WeatherResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      WeatherResponse(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        generationtimeMs: json["generationtime_ms"].toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        currentWeather: CurrentWeather.fromJson(json["current_weather"]),
        hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
        hourly: Hourly.fromJson(json["hourly"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "current_weather": currentWeather.toJson(),
        "hourly_units": hourlyUnits.toJson(),
        "hourly": hourly.toJson(),
      };
}

class CurrentWeather {
  double temperature;
  double windspeed;
  double winddirection;
  int weathercode;
  int isDay;
  String time;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeather.fromRawJson(String str) =>
      CurrentWeather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        temperature: json["temperature"].toDouble(),
        windspeed: json["windspeed"].toDouble(),
        winddirection: json["winddirection"],
        weathercode: json["weathercode"],
        isDay: json["is_day"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "windspeed": windspeed,
        "winddirection": winddirection,
        "weathercode": weathercode,
        "is_day": isDay,
        "time": time,
      };
}

class Hourly {
  List<String> time;
  List<double> temperature2M;
  List<int> weatherCode;
  List<int> isDay;

  Hourly({
    required this.time,
    required this.temperature2M,
    required this.weatherCode,
    required this.isDay,
  });

  factory Hourly.fromRawJson(String str) => Hourly.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        time: List<String>.from(json["time"].map((x) => x)),
        temperature2M: List<double>.from(
          json["temperature_2m"].map((x) => x.toDouble()),
        ),
        weatherCode: List<int>.from(json["weathercode"].map((x) => x)),
        isDay: List<int>.from(json["is_day"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) => x)),
        "temperature_2m": List<dynamic>.from(temperature2M.map((x) => x)),
      };
}

class HourlyUnits {
  String time;
  String temperature2M;

  HourlyUnits({
    required this.time,
    required this.temperature2M,
  });

  factory HourlyUnits.fromRawJson(String str) =>
      HourlyUnits.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
        time: json["time"],
        temperature2M: json["temperature_2m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature_2m": temperature2M,
      };
}
