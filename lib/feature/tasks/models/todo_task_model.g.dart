// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoTaskModelAdapter extends TypeAdapter<TodoTaskModel> {
  @override
  final int typeId = 2;

  @override
  TodoTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoTaskModel(
      id: fields[0] as int,
      parentId: fields[1] as int,
      content: fields[2] as String,
      isDone: fields[3] as bool,
      noteDate: fields[5] as DateTime,
    )..isFolded = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, TodoTaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parentId)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.isFolded)
      ..writeByte(5)
      ..write(obj.noteDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
