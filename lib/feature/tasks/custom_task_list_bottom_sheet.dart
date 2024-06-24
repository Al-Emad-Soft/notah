import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/feature/tasks/subtask_list_tile.dart';
import 'package:notah/funtions/custom_bottom_sheet_title.dart';
import 'package:notah/feature/tasks/models/todo_task_model.dart';
import 'package:notah/view_models/todos_view_model.dart';
import 'package:notah/widgets/date_and_time_info_content.dart';

Future<dynamic> showTaskListBottomSheet(
    {required BuildContext context,
    required Function() onSave,
    TodoTaskModel? initTask}) {
  final tasksProv = Provider.of<TodosViewModel>(context, listen: false);
  tasksProv
      .setCurTask(initTask?.copy() ?? TodoTaskModel(noteDate: DateTime.now()));
  final _listController = ScrollController();
  return showCustomTaskBottomSheetTitled(
    context: context,
    initTitle: tasksProv.curTask.content,
    child: Consumer<TodosViewModel>(
      builder: (context, tasksVM, child) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView(
              controller: _listController,
              physics: ClampingScrollPhysics(),
              shrinkWrap: false,
              children: [
                DateAndTimeInfoContents(
                  onDateSaved: (x) {
                    tasksVM.changeCurrTaskDate(x);
                  },
                  onTimeSaved: (x) {
                    tasksVM.changeCurrTaskTime(x);
                  },
                  infoText: "Subtasks".tr() + ": ${tasksVM.curSubtasks.length}",
                  dateText:
                      DateFormat("dd/MM/yyyy").format(tasksVM.curTask.noteDate),
                  timeText:
                      DateFormat().add_jm().format(tasksVM.curTask.noteDate),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    final subtask = tasksVM.curSubtasks[index];
                    return SubtaskListTile(
                      editable: true,
                      subtaskModel: subtask,
                      onCheckChanged: (value) {
                        subtask.isDone = value!;
                        tasksVM.refresh();
                      },
                      onDelete: () {
                        tasksVM.deleteSubtask(index);
                      },
                    );
                  },
                  itemCount: tasksProv.curSubtasks.length,
                  shrinkWrap: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(
                          10,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            tasksVM.addToCurrentSubtasks(
                              TodoTaskModel(
                                parentId: tasksVM.curTask.id,
                                noteDate: DateTime.now(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 1,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
    onSave: (newTitle) async {
      if (newTitle == "" || tasksProv.curSubtasks.length == 0) {
        return;
      }
      tasksProv.curTask.content = newTitle;
      await tasksProv.saveCurrentTask();
      if (initTask != null) {
        initTask.isDone != tasksProv.curTask.isDone;
      }

      Navigator.pop(context);
    },
  );
}
