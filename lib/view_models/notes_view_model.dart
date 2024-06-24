// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notah/constants/app_const.dart';

import 'package:notah/feature/notes/models/note_task_model.dart';

class NotesTasksViewModel extends ChangeNotifier {
  final Box<NoteTaskModel> box = Hive.box(kNotesTasksBox);
  NoteTaskModel? _curNoteTask;
  final List<NoteTaskModel> _selectedTasks = [];

  List<NoteTaskModel> get selectedTasks => _selectedTasks;
  bool get isSelectionMode => _selectedTasks.length > 0;
  bool get isSelectionFavo =>
      selectedTasks.where((x) => x.favorite).length == selectedTasks.length;
  NoteTaskModel? get curNoteTask => _curNoteTask;
  List<NoteTaskModel> get favoTasks =>
      box.values.where((x) => x.favorite).toList();
  List<NoteTaskModel> get notFavoTasks =>
      box.values.where((x) => !x.favorite).toList();
  List<NoteTaskModel> get allTasks => box.values.toList();

  List<NoteTaskModel> getFolderFavoTasks(int folderId) {
    if (folderId == -1) {
      return favoTasks;
    }

    return box.values
        .where((x) => x.favorite && x.folderId == folderId)
        .toList();
  }

  Future<void> changeSelectedTasksFolder(int folderId) async {
    for (var t in selectedTasks) {
      final found = allTasks.singleWhere((x) => x.id == t.id);
      found.folderId = folderId;
      await found.save();
    }

    selectedTasks.clear();
    notifyListeners();
  }

  Future<bool> deleteFolderTasks(int folderId) async {
    try {
      final found = box.values.where((x) => x.folderId == folderId);
      for (var t in found) {
        await t.delete();
      }
      return true;
    } catch (e) {}

    return false;
  }

  Future<void> deleteSelectedTasks() async {
    for (var t in selectedTasks) {
      await deleteNoteTaskById(id: t.id, listen: false);
    }

    selectedTasks.clear();
    notifyListeners();
  }

  void changeSelectedFavorite() {
    bool isFavo = isSelectionFavo;
    for (var s in selectedTasks) {
      changeFavorite(task: s, value: !isFavo);
    }

    notifyListeners();
  }

  void clearSelections() {
    if (selectedTasks.isNotEmpty) {
      selectedTasks.clear();
      notifyListeners();
    }
  }

  bool checkSelectedTask(NoteTaskModel task) {
    return selectedTasks.where((x) => x.id == task.id).length > 0;
  }

  void selectTask(NoteTaskModel task) {
    NoteTaskModel found = selectedTasks.singleWhere((x) => x.id == task.id,
        orElse: () => NoteTaskModel(noteDate: DateTime.now(), id: -1));
    if (found.id != -1) {
      selectedTasks.remove(found);
      notifyListeners();

      return;
    }

    selectedTasks.add(task);
    notifyListeners();
  }

  List<NoteTaskModel> getFolderTasks(int folderId) {
    if (folderId == -1) {
      return allTasks;
    }
    return allTasks.where((x) => x.folderId == folderId).toList();
  }

  List<NoteTaskModel> getFolderNotFavoTasks(int folderId) {
    if (folderId == -1) {
      return notFavoTasks;
    }
    return allTasks
        .where((x) => !x.favorite && x.folderId == folderId)
        .toList();
  }

  void setCurrentNoteTask(NoteTaskModel task) {
    _curNoteTask = task;
    notifyListeners();
  } //

  Future<void> changeFavorite(
      {required NoteTaskModel task, bool? value}) async {
    final found = box.values.singleWhere((x) => x.id == task.id);
    found.favorite = value != null ? value : !found.favorite;
    await found.save();
    notifyListeners();
  }

  Future<void> deleteNoteTaskById({required int id, bool listen = true}) async {
    final found = box.values.singleWhere((x) => x.id == id);
    await found.delete();

    if (listen) notifyListeners();
  }

  Future<void> saveNoteTask() async {
    if (curNoteTask != null) {
      if (curNoteTask!.id != -1) {
        var found =
            box.values.toList().singleWhere((x) => x.id == curNoteTask!.id);
        found.content = curNoteTask!.content;
        found.title = curNoteTask!.title;
        found.noteDate = curNoteTask!.noteDate;
        await found.save();
      } else {
        int nextId = box.values.toList().length + 1;
        if (box.values.toList().isNotEmpty) {
          nextId = box.values.toList().last.id + 1;
        }

        _curNoteTask!.id = nextId;
        await box.add(curNoteTask!);
      }
      notifyListeners();
    }
  }

  String getNoteDataToShare(NoteTaskModel task) {
    return "${task.title}\n\t${task.content}";
  }

  void changeCurrTaskDate(DateTime date) {
    if (_curNoteTask == null) return;
    final x = _curNoteTask!.noteDate;
    _curNoteTask!.noteDate =
        DateTime(date.year, date.month, date.day, x.hour, x.minute);
    notifyListeners();
  }

  void changeCurrTaskTime(TimeOfDay timeOfDay) {
    if (_curNoteTask == null) return;
    final x = _curNoteTask!.noteDate;
    _curNoteTask!.noteDate =
        DateTime(x.year, x.month, x.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
