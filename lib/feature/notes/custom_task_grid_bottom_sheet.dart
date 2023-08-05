// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/notes_folders/tasks_folders_view_model.dart';
import 'package:notah/funtions/custom_bottom_sheet_title.dart';
import 'package:notah/view_models/notes_view_model.dart';
import 'package:notah/widgets/date_and_time_info_content.dart';

import 'models/note_task_model.dart';

Future<dynamic> showGridTasksBottomSheet(
    {required BuildContext context,
    required Function() onSave,
    NoteTaskModel? initTask}) {
  final tasksProv = Provider.of<NotesTasksViewModel>(context, listen: false);
  final folderProv = Provider.of<TasksFoldersViewModel>(context, listen: false);
  tasksProv.setCurrentNoteTask(
      initTask?.copy() ?? NoteTaskModel(noteDate: DateTime.now()));
  return showCustomTaskBottomSheetTitled(
    context: context,
    initTitle: tasksProv.curNoteTask!.title,
    onSave: (newTitle) async {
      if (newTitle.isEmpty || tasksProv.curNoteTask!.content.isEmpty) return;
      tasksProv.curNoteTask!.title = newTitle;
      tasksProv.curNoteTask!.folderId = folderProv.getCurrentFolderId();

      await tasksProv.saveNoteTask();
      onSave;
      Navigator.pop(context);
    },
    child: Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Consumer<NotesTasksViewModel>(
              builder: (context, notesVM, child) => DateAndTimeInfoContents(
                onDateSaved: (x) {
                  notesVM.changeCurrTaskDate(x);
                },
                onTimeSaved: (x) {
                  notesVM.changeCurrTaskTime(x);
                },
                infoText:
                    "Letters".tr() + ": ${notesVM.curNoteTask!.content.length}",
                dateText: DateFormat("dd/MM/yyyy")
                    .format(notesVM.curNoteTask!.noteDate),
                timeText:
                    DateFormat().add_jm().format(notesVM.curNoteTask!.noteDate),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Consumer<NotesTasksViewModel>(
                  builder: (context, taskVM, child) => TextFormField(
                    onChanged: (value) {
                      tasksProv.curNoteTask!.content = value;

                      tasksProv.setCurrentNoteTask(tasksProv.curNoteTask!);
                    },
                    maxLines: null,
                    initialValue: taskVM.curNoteTask!.content,
                    decoration: InputDecoration(
                      hintText: "Content".tr(),
                    ),
                    style: currTheme(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
