import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather currentWeather;

  WeatherWidget({required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${currentWeather.temperature}°C',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      currentWeather.condition,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${currentWeather.icon}@2x.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
