// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';

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
                            itemBuilder: (context, i) => CustomTaskListTile(
                              taskModel: tasksVM.notDoneTasks[i],
                            ),
                            shrinkWrap: true,
                          ),
                        ),
                        Visibility(
                          visible: tasksVM.doneTasks.length > 0,
                          child: ExpansionTile(
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
