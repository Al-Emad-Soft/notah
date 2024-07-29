// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priced_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PricedTaskModelAdapter extends TypeAdapter<PricedTaskModel> {
  @override
  final int typeId = 5;

  @override
  PricedTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PricedTaskModel(
      name: fields[0] as String,
      qty: fields[1] as int,
      price: fields[2] as int,
      parentId: fields[3] as int,
      id: fields[4] as int,
      totalPrice: fields[6] as int,
      noteDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PricedTaskModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.qty)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.noteDate)
      ..writeByte(6)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PricedTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
