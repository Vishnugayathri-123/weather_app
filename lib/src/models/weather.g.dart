// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 0;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      date: fields[0] as String,
      temperature: fields[1] as double,
      condition: fields[2] as String,
      icon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
