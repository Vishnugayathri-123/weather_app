import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 0)
class Weather extends HiveObject {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final double temperature;

  @HiveField(2)
  final String condition;

  @HiveField(3)
  final String icon;

  Weather({
    required this.date,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json['dt_txt'] ?? '',  // Ensure date is not null
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['description'] ?? '',  // Ensure condition is not null
      icon: json['weather'][0]['icon'] ?? '01d',  // Ensure icon is not null, default to '01d'
    );
  }
}
