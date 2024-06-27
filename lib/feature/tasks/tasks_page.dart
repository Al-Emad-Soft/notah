// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/tasks/models/todo_task_model.dart';
import 'package:notah/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';

import 'package:notah/feature/tasks/task_card.dart';
import 'package:notah/view_models/todos_view_model.dart';
import 'package:notah/widgets/custom_floating_action_button.dart';
import 'package:notah/widgets/text_content_info.dart';

import 'custom_task_list_bottom_sheet.dart';

class TodosTasksPage extends StatelessWidget {
  const TodosTasksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Consumer<TodosViewModel>(
        builder: (context, tasksVM, child) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextsContentInfo(
                              mainAxisAlignment: MainAxisAlignment.start,
                              fontSize: 15,
                              info: [
                                "Tasks".tr() +
                                    ": ${tasksVM.mainTasks.length}/${tasksVM.doneTasks.length}"
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                            itemCount: tasksVM.notDoneTasks.length,
                            itemBuilder: (context, i) => Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                color: Colors.red.shade400,
                                width: 20,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (direction) {
                                tasksVM
                                    .deleteTaskAndSave(tasksVM.notDoneTasks[i]);
                              },
                              confirmDismiss: (direction) async {
                                bool isDeleted = false;
                                await showDeleteDialog(
                                  context,
                                  content:
                                      'سيتم حذف هذه المهمة مع جميع المهام الفرعية الخاصة بها',
                                  onDelete: () {
                                    isDeleted = true;
                                    Navigator.pop(context);
                                  },
                                );
                                return isDeleted;
                              },
                              key: ValueKey<TodoTaskModel>(
                                  tasksVM.notDoneTasks[i]),
                              child: CustomTaskListTile(
                                taskModel: tasksVM.notDoneTasks[i],
                              ),
                            ),
                            shrinkWrap: true,
                          ),
                        ),
                        Visibility(
                          visible: tasksVM.doneTasks.length > 0,
                          child: ExpansionTile(
                            controller: tasksVM.doneTaskscontroller,
                            onExpansionChanged: (value) =>
                                tasksVM.changeDoneTasksFolded(),
                            initiallyExpanded: tasksVM.doneTaskFolded,
                            textColor:
                                currTheme(context).expansionTileTheme.textColor,
                            iconColor:
                                currTheme(context).expansionTileTheme.iconColor,
                            title: Text(
                              "Completed".tr(),
                              style: currTheme(context).textTheme.bodySmall,
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 10),
                                child: ListView.builder(
                                  itemCount: tasksVM.doneTasks.length,
                                  itemBuilder: (context, i) =>
                                      CustomTaskListTile(
                                    taskModel: tasksVM.doneTasks[i],
                                  ),
                                  shrinkWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomFloatingActionButton(
                onPressed: () {
                  showTaskListBottomSheet(
                    context: context,
                    onSave: () {},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<dynamic> showDeleteDialog(
  BuildContext context, {
  required String content,
  required Function() onDelete,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "Delete Alert".tr(),
      ),
      content: Row(
        children: [
          Container(
            color: Colors.red,
            height: 80,
            width: 5,
          ),
          Expanded(
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(5),
              color: Colors.red.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red.shade400,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Warning'.tr(),
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      content,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        CustomIconButton(
          radius: 45,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        CustomIconButton(
          radius: 45,
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            size: 22,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
