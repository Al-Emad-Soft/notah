// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteTaskModelAdapter extends TypeAdapter<NoteTaskModel> {
  @override
  final int typeId = 1;

  @override
  NoteTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteTaskModel(
      id: fields[0] as int,
      title: fields[1] as String,
      content: fields[2] as String,
      folderId: fields[6] as int,
      noteDate: fields[3] as DateTime,
    )..favorite = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, NoteTaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.noteDate)
      ..writeByte(4)
      ..write(obj.favorite)
      ..writeByte(6)
      ..write(obj.folderId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
