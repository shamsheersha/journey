// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 1;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      place: fields[0] as String,
      startDate: fields[1] as DateTime,
      endDate: fields[2] as DateTime,
      budget: fields[3] as String,
      notes: fields[4] as String,
      travelMethod: fields[5] as String,
      images: (fields[6] as List).cast<String>(),
      checkboxes: (fields[7] as Map?)?.cast<String, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.place)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.budget)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.travelMethod)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.checkboxes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
