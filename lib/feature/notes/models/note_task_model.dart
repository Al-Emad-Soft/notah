import 'package:hive/hive.dart';

part 'note_task_model.g.dart';

@HiveType(typeId: 1)
class NoteTaskModel extends HiveObject {
  @HiveField(0)
  int id = -1;
  @HiveField(1)
  String title = "";
  @HiveField(2)
  String content = "";
  @HiveField(3)
  DateTime noteDate;
  @HiveField(4)
  bool favorite = false;
  @HiveField(6)
  int folderId = -1;
  NoteTaskModel(
      {this.id = -1,
      this.title = "",
      this.content = "",
      this.folderId = -1,
      required this.noteDate});

  @override
  String toString() {
    return 'NoteTask(id: $id, title: $title, content: $content, noteDate: $noteDate)';
  }
}

extension NoteTaskExtension on NoteTaskModel {
  NoteTaskModel copy() {
    return NoteTaskModel(
      noteDate: noteDate,
      content: content,
      id: id,
      title: title,
      folderId: folderId,
    );
  }
}
