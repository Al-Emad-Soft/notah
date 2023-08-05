// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_folder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskFolderModelAdapter extends TypeAdapter<TaskFolderModel> {
  @override
  final int typeId = 3;

  @override
  TaskFolderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskFolderModel(
      id: fields[0] as int,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskFolderModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskFolderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
