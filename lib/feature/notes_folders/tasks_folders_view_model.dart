import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notah/constants/app_const.dart';
import 'package:notah/feature/notes_folders/task_folder_model.dart';

class TasksFoldersViewModel extends ChangeNotifier {
  TaskFolderModel? _currentFolder;
  TaskFolderModel? get currentFolder => _currentFolder;

  final Box<TaskFolderModel> box = Hive.box(kTasksFoldersBox);
  List<TaskFolderModel> get allfolders => box.values.toList();

  Future<void> saveFolder(TaskFolderModel folder) async {
    print('--------------------- ${folder.id}');
    if (folder.id == -1) {
      folder.id = getNewId();
      await box.add(folder);
    } else {
      final found = getFolder(folder.id);
      found.title = folder.title;
      await found.save();
    }

    notifyListeners();
  }

  TaskFolderModel getFolder(int id) {
    return box.values.singleWhere((x) => x.id == id);
  }

  int getCurrentFolderId() {
    return currentFolder != null ? currentFolder!.id : -1;
  }

  bool checkFolderIsSelected(TaskFolderModel? folder) {
    if (_currentFolder == null) return false;

    return folder!.id == _currentFolder!.id;
  }

  void setSelectedFolder(TaskFolderModel? folder) {
    _currentFolder = folder;
    notifyListeners();
  }

  Future<void> deleteFolder(TaskFolderModel folder) async {
    final found = allfolders.singleWhere((x) => x.id == folder.id);
    await found.delete();
    _currentFolder = null;
    notifyListeners();
  }

  int getNewId() {
    if (box.values.isEmpty) {
      return 1;
    }

    return box.values.last.id + 1;
  }
}
