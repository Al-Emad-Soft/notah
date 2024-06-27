import 'package:hive/hive.dart';

part 'todo_task_model.g.dart';

@HiveType(typeId: 2)
class TodoTaskModel extends HiveObject {
  @HiveField(0)
  int id = -1;
  @HiveField(1)
  int parentId = -1;
  @HiveField(2)
  String content;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  bool isFolded = true;
  @HiveField(5)
  DateTime noteDate;

  TodoTaskModel({
    this.id = -1,
    this.parentId = -1,
    this.content = "",
    this.isDone = false,
    required this.noteDate,
  });

  void copyFrom(TodoTaskModel task) {
    id = task.id;
    parentId = task.parentId;
    content = task.content;
    isDone = task.isDone;
    noteDate = task.noteDate;
  }

  void changeDone(bool value) {
    isDone = value;
  }
}

extension TodoTaskExtension on TodoTaskModel {
  TodoTaskModel copy() {
    return TodoTaskModel(
        id: id,
        parentId: parentId,
        noteDate: noteDate,
        content: content,
        isDone: isDone);
  }
}
