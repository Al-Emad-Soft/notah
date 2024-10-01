import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notah/constants/app_const.dart';
import 'package:notah/feature/priced_tasks/models/priced_task_model.dart';

class PricedTasksViewModel extends ChangeNotifier {
  final Box<PricedTaskModel> box = Hive.box(kPricedTasksBox);
  final List<PricedTaskModel> mainTasks = [];
  List<PricedTaskModel> _deletedTasks = [];

  final Map<int, bool> expanded = Map();
  final List<PricedTaskModel> currentSubtasks = [];
  late PricedTaskModel? currentMainTask;

  List<PricedTaskModel> getCurrentSubtasks(
      {required PricedTaskModel mainTask}) {
    return box.values.where((x) => x.parentId == mainTask.id).toList();
  }

  List<PricedTaskModel> loadCurrentSubtasks({PricedTaskModel? mainTask}) {
    _deletedTasks.clear();
    if (mainTask != null) currentMainTask = mainTask;
    final tasks =
        box.values.where((x) => x.parentId == currentMainTask!.id).toList();
    currentSubtasks.clear();

    for (var t in tasks) {
      currentSubtasks.add(t.copyWith());
    }

    return currentSubtasks;
  }

  void loadAllMainTasks() {
    mainTasks.clear();
    final tasks = box.values.where((x) => x.parentId == -1);
    mainTasks.addAll(tasks);
    for (var t in tasks) {
      if (!expanded.containsKey(t.id)) {
        expanded[t.id] = false;
      }
    }
    notifyListeners();
  }

  void getMainTaskDetailsById(int mainTaskId) {
    currentMainTask =
        box.values.singleWhere((x) => x.id == mainTaskId).copyWith();
    loadCurrentSubtasks(mainTask: currentMainTask);
    if (!expanded.containsKey(mainTaskId)) {
      expanded[mainTaskId] = false;
    }
    notifyListeners();
  }

  bool isExpanded(int mainTaskId) {
    return expanded[mainTaskId]!;
  }

  void toggleSubtasks(int mainTaskId) {
    if (expanded.containsKey(mainTaskId)) {
      expanded[mainTaskId] = !expanded[mainTaskId]!;
    }
  }

  void addNewMainTask() {
    currentMainTask = PricedTaskModel(noteDate: DateTime.now());
    currentSubtasks.clear();
  }

  void addNewSubtask() {
    currentSubtasks.add(
      PricedTaskModel(
        qty: 1,
        parentId: currentMainTask!.id,
        noteDate: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void changeMainTaskDate(DateTime date) {
    if (currentMainTask == null) return;
    final x = currentMainTask!.noteDate;
    currentMainTask!.noteDate =
        DateTime(date.year, date.month, date.day, x.hour, x.minute);
    notifyListeners();
  }

  void changeMainTaskTime(TimeOfDay timeOfDay) {
    if (currentMainTask == null) return;
    final x = currentMainTask!.noteDate;
    currentMainTask!.noteDate =
        DateTime(x.year, x.month, x.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }

  void changeSubtaskPrice(int index, int price) {
    final task = currentSubtasks.elementAt(index);
    task.price = price;
    notifyListeners();
  }

  void changeMainTaskName(String name) {
    currentMainTask!.name = name;
  }

  void changeSubtaskQty(int index, int qty) {
    if (qty <= 0) qty = 1;
    if (qty >= 99) qty = 99;

    final task = currentSubtasks.elementAt(index);
    task.qty = qty;
    notifyListeners();
  }

  void changeSubtaskName(int index, String name) {
    final task = currentSubtasks.elementAt(index);
    task.name = name;
  }

  bool checkAllowedTask() {
    return currentSubtasks.length > 0 &&
        !(currentSubtasks
                .where((x) => x.name == "" || x.price <= 0 || x.qty <= 0)
                .length ==
            currentSubtasks.length) &&
        !(currentMainTask == null || currentMainTask!.name == "");
  }

  void resetCurrTask() {
    currentSubtasks.clear();
    currentMainTask = null;
  }

  Future<void> _saveTask(PricedTaskModel task) async {
    if (task.parentId != -1 &&
        (task.price <= 0 || task.qty <= 0 || task.name.isEmpty)) return;

    if (task.id != -1) {
      var found = box.values.singleWhere((x) => x.id == task.id);

      found.price = task.price;
      found.qty = task.qty;
      found.name = task.name;
      found.totalPrice = task.totalPrice;
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
    final subtask = currentSubtasks[index];
    currentSubtasks.removeAt(index);

    if (subtask.id == -1 || currentSubtasks.isEmpty) {
      notifyListeners();

      return false;
    }
    currentSubtasks.removeWhere((x) => x.id == subtask.id);
    _deletedTasks.add(subtask);
    notifyListeners();
    return true;
  }

  Future<void> deleteTaskAndSave(PricedTaskModel task) async {
    print(task.id);
    if (task.id == -1) {
      return;
    }
    final found = box.values.singleWhere((x) => x.id == task.id);

    //_tasks.removeWhere((x) => x.id == task.id);
    await _removeAllSubtasksAndSave(task);
    await found.delete();
    mainTasks.removeWhere(
      (x) => x.id == task.id,
    );
    notifyListeners();
  }

  Future<void> _removeAllSubtasksAndSave(PricedTaskModel parentTask) async {
    final tasks = box.values.where((x) => x.parentId == parentTask.id);
    for (var subtask in tasks) {
      await subtask.save();
    }
    // await found.delete();
    notifyListeners();
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
    _deletedTasks.clear();
    if (currentMainTask != null) {
      currentMainTask!.totalPrice = 0;
      for (var t in currentSubtasks) {
        currentMainTask!.totalPrice += t.price * t.qty;
      }

      await _saveTask(currentMainTask!);

      for (var t in currentSubtasks) {
        if (t.name.isEmpty) continue;
        t.parentId = currentMainTask!.id;
        await _saveTask(t);
      }
    }
    loadAllMainTasks();
    notifyListeners();
  }
}
