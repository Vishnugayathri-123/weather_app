import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import '../models/weather.dart';

class WeatherService {
  static const String apiKey = '3aeb4c478f77eeff3fd6a7450e76da5b';
  static const String currentWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<Weather> fetchCurrentWeather(String city) async {
    final response = await http.get(Uri.parse('$currentWeatherUrl?q=$city&appid=$apiKey&units=metric'));
    print('Current Weather Response: ${response.body}');
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<Weather>> fetchWeatherForecast(String city) async {
    final response = await http.get(Uri.parse('$forecastUrl?q=$city&appid=$apiKey&units=metric'));
    print('Forecast Response: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['list'];
      return data.map((item) => Weather.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<void> saveWeatherData(Weather weather, List<Weather> forecast) async {
    var box = await Hive.openBox('weatherBox');
    box.put('currentWeather', weather);
    box.put('forecast', forecast);
  }

  Future<Map<String, dynamic>> loadWeatherData() async {
    var box = await Hive.openBox('weatherBox');
    Weather? currentWeather = box.get('currentWeather');
    List<Weather>? forecast = box.get('forecast');
    return {'currentWeather': currentWeather, 'forecast': forecast};
  }
}
