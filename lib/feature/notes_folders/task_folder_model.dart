// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'task_folder_model.g.dart';

@HiveType(typeId: 3)
class TaskFolderModel extends HiveObject {
  @HiveField(0)
  int id = -1;
  @HiveField(1)
  String title;

  TaskFolderModel({
    this.id = -1,
    this.title = "",
  });
}
