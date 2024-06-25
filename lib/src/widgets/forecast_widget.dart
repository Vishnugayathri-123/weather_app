import 'package:flutter/material.dart';

import '../models/weather.dart';

class ForecastWidget extends StatelessWidget {
  final Weather weather;

  ForecastWidget({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weather.date.split(' ')[0],  // Display only the date part
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Image.network(
              'https://openweathermap.org/img/wn/${weather.icon}.png',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8.0),
            Text(
              '${weather.temperature}°C',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              weather.condition,
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
