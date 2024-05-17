// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensesAdapter extends TypeAdapter<Expenses> {
  @override
  final int typeId = 2;

  @override
  Expenses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expenses(
      id: fields[3] as int,
      amount: fields[0] as String,
      description: fields[2] as String,
      item: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expenses obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
