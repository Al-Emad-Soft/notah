import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notah/constants/app_const.dart';
import 'package:notah/feature/tasks/models/todo_task_model.dart';

class TodosViewModel extends ChangeNotifier {
  final Box<TodoTaskModel> box = Hive.box(kTodosTasksBox);
  final ExpansionTileController doneTaskscontroller = ExpansionTileController();
  final Map<int, ExpansionTileController> tasksExpController =
      Map<int, ExpansionTileController>();

  TodoTaskModel? _curTask = null;
  List<TodoTaskModel> _curSubtasks = [];
  List<TodoTaskModel> _deletedTasks = [];
  bool _isDoneTaskFolded = true;

  List<TodoTaskModel> get doneTasks =>
      mainTasks.where((x) => x.isDone).toList(growable: true);
  List<TodoTaskModel> get notDoneTasks {
    final all = mainTasks.where((x) => !x.isDone).toList(growable: true);
    return all;
  }

  List<TodoTaskModel> get deletedTasks => _deletedTasks;
  List<TodoTaskModel> get curSubtasks => _curSubtasks;
  List<TodoTaskModel> get mainTasks =>
      box.values.where((x) => x.parentId == -1).toList();
  TodoTaskModel get curTask => _curTask!;

  bool get doneTaskFolded => _isDoneTaskFolded;
  Future<void> updateExpanstion(TodoTaskModel task) async {
    final found = box.values.singleWhere((x) => x.id == task.id);
    await found.save();
    notifyListeners();
  }

  Future<void> changeFoldAndSave(
      TodoTaskModel task, Function(bool) onFold) async {
    final found = box.values.singleWhere((x) => x.id == task.id);

    found.isFolded = !found.isFolded;
    onFold(found.isFolded);

    await found.save();
    notifyListeners();
  }

  void changeDoneTasksFolded() {
    _isDoneTaskFolded = !_isDoneTaskFolded;
  }

  void _loadSubtasks(TodoTaskModel parentTask) {
    _curSubtasks.clear();
    if (parentTask.id == -1) return;

    final found = box.values.where((x) => x.parentId == parentTask.id).toList();
    _curSubtasks.clear();
    found.forEach((x) {
      _curSubtasks.add(x.copy());
    });
  }

  void addToCurrentSubtasks(TodoTaskModel task) {
    _curSubtasks.add(task);
    refresh();
  }

  List<TodoTaskModel> getSubtasks(TodoTaskModel parentTask) {
    return box.values.where((x) => x.parentId == parentTask.id).toList();
  }

  String getTaskDataToShare(TodoTaskModel task) {
    String text = "${task.content} ${task.isDone ? "(✓)" : ""}\n";
    final found = box.values.where((x) => x.parentId == task.id).toList();
    for (var sub in found) {
      text += " - ${sub.content} ${sub.isDone ? "(✓)" : ""}\n";
    }
    return text;
  }

  TodoTaskModel setCurTask(TodoTaskModel task) {
    resetCurrTask();
    _curTask = task;
    _loadSubtasks(_curTask!);
    return _curTask!;
  }

  Future<void> _saveTask(TodoTaskModel task) async {
    if (task.id != -1) {
      var found = box.values.singleWhere((x) => x.id == task.id);
      found.content = task.content;
      found.isDone = task.isDone;
      found.noteDate = task.noteDate;
      await found.save();
    } else {
      int nextId = box.values.length + 1;
      if (box.values.isNotEmpty) {
        nextId = box.values.last.id + 1;
      }
      task.id = nextId;
      await box.add(task);
    }
  }

  bool deleteSubtask(int index) {
    final subtask = _curSubtasks[index];
    _curSubtasks.removeAt(index);

    if (subtask.id == -1 || _curSubtasks.isEmpty) {
      notifyListeners();

      return false;
    }
    _curSubtasks.removeWhere((x) => x.id == subtask.id);
    _deletedTasks.add(subtask);
    notifyListeners();
    return true;
  }

  Future<void> _removeAllSubtasksAndSave(TodoTaskModel parentTask) async {
    final tasks = box.values.where((x) => x.parentId == parentTask.id);
    for (var subtask in tasks) {
      await subtask.save();
    }
    // await found.delete();
    notifyListeners();
  }

  Future<void> getMainTaskDoneValue(TodoTaskModel task) async {
    final mainTask = box.values.singleWhere((x) => x.id == task.id);
    bool notDoneSubtasks =
        box.values.where((x) => x.parentId == task.id && !x.isDone).length > 0;
    mainTask.isDone = !notDoneSubtasks;
    await mainTask.save();
  }

  void changeDone(TodoTaskModel task) {
    task.isDone = !task.isDone;

    box.values.where((x) => x.parentId == task.id).forEach((subtask) {
      subtask.isDone = task.isDone;
    });

    notifyListeners();
  }

  Future<void> changeDoneAndSave(TodoTaskModel task) async {
    final found = box.values.singleWhere((x) => x.id == task.id);
    found.isDone = !found.isDone;
    await found.save();
    box.values.where((x) => x.parentId == task.id).forEach((subtask) async {
      subtask.isDone = task.isDone;
      await subtask.save();
    });

    notifyListeners();
  }

  Future<void> deleteTaskAndSave(TodoTaskModel task) async {
    print(task.id);
    if (task.id == -1) {
      return;
    }
    final found = box.values.singleWhere((x) => x.id == task.id);

    //_tasks.removeWhere((x) => x.id == task.id);
    await _removeAllSubtasksAndSave(task);
    await found.delete();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  TodoTaskModel getTaskById(int id) {
    return box.values.singleWhere((x) => x.id == id);
  }

  bool checkAllowedTask() {
    return curSubtasks.length > 0 &&
        !(curSubtasks.where((x) => x.content == "").length ==
            curSubtasks.length) &&
        !(_curTask == null || _curTask!.content == "");
  }

  void resetCurrTask() {
    _curSubtasks = [];
    _deletedTasks = [];
    _curTask = null;
  }

  Future<void> saveCurrentTask() async {
    if (!checkAllowedTask()) {
      resetCurrTask();

      return;
    }
    _deletedTasks.forEach((subtask) async {
      final found = box.values.singleWhere((x) => x.id == subtask.id);
      await found.delete();
    });

    if (_curTask != null) {
      await _saveTask(curTask);
      for (var t in curSubtasks) {
        if (t.content.isEmpty) continue;
        t.parentId = curTask.id;
        await _saveTask(t);
      }
    }

    await getMainTaskDoneValue(_curTask!);
    refresh();
  }

  void changeCurrTaskDate(DateTime date) {
    if (_curTask == null) return;
    final x = _curTask!.noteDate;
    _curTask!.noteDate =
        DateTime(date.year, date.month, date.day, x.hour, x.minute);
    notifyListeners();
  }

  void changeCurrTaskTime(TimeOfDay timeOfDay) {
    if (_curTask == null) return;
    final x = _curTask!.noteDate;
    _curTask!.noteDate =
        DateTime(x.year, x.month, x.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }
}
