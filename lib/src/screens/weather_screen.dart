import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';
import '../service/weather_service.dart';
import '../widgets/forecast_widget.dart';
import '../widgets/weather_widgets.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  WeatherService _weatherService = WeatherService();
  Weather? _currentWeather;
  List<Weather>? _forecast;

  @override
  void initState() {
    super.initState();
    _loadLastSelectedCity();
  }

  void _loadLastSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('lastCity');
    print('Last selected city: $lastCity');
    if (lastCity != null) {
      var weatherData = await _weatherService.loadWeatherData();
      setState(() {
        _currentWeather = weatherData['currentWeather'];
        _forecast = _filterForecastByDate(weatherData['forecast']);
      });
    }
  }

  List<Weather> _filterForecastByDate(List<Weather> forecast) {
    Map<String, Weather> filteredForecast = {};
    for (var weather in forecast) {
      String date = weather.date.split(' ')[0]; // Extracting date part
      if (!filteredForecast.containsKey(date)) {
        filteredForecast[date] = weather;
      }
    }
    return filteredForecast.values.toList();
  }

  void _fetchWeatherData(String city) async {
    try {
      var weather = await _weatherService.fetchCurrentWeather(city);
      var forecast = await _weatherService.fetchWeatherForecast(city);
      setState(() {
        _currentWeather = weather;
        _forecast = _filterForecastByDate(forecast);
      });
      _weatherService.saveWeatherData(weather, forecast);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lastCity', city);
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch weather data. Please try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _fetchWeatherData(_controller.text);
                  },
                ),
              ),
            ),
            if (_currentWeather != null)
              WeatherWidget(currentWeather: _currentWeather!),
            Expanded(
              child: _forecast == null
                  ? Center(child: Text('No data'))
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: _forecast!.length,
                itemBuilder: (context, index) {
                  return ForecastWidget(weather: _forecast![index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
