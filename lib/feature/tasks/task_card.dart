import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/tasks/custom_task_list_bottom_sheet.dart';
import 'package:notah/feature/tasks/subtask_list_tile.dart';
import 'package:notah/models/popup_menu_item_data.dart';
import 'package:notah/view_models/todos_view_model.dart';
import 'package:notah/widgets/custom_popup_menu.dart';
import 'package:notah/widgets/text_content_info.dart';
import 'package:share_plus/share_plus.dart';
import 'models/todo_task_model.dart';

class CustomTaskListTile extends StatelessWidget {
  final TodoTaskModel taskModel;
  CustomTaskListTile({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosViewModel>(builder: (context, tasksVM, child) {
      final subtasks = tasksVM.getSubtasks(taskModel);
      taskModel.copyFrom(tasksVM.getTaskById(taskModel.id));
      return Card(
        borderOnForeground: false,
        clipBehavior: Clip.antiAlias,
        color: currTheme(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: !taskModel.isDone
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: Colors.greenAccent,
                ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            showTaskListBottomSheet(
              context: context,
              initTask: taskModel,
              onSave: () {},
            );
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPopupMenuButton(
                                items: [
                                  PopupMenuItemData(
                                    icon: Icon(
                                      taskModel.isDone
                                          ? Icons.check_box
                                          : Icons.check_box_rounded,
                                      color: taskModel.isDone
                                          ? Colors.green[900]
                                          : Colors.black54,
                                    ),
                                    title: taskModel.isDone
                                        ? "Unmark as done".tr()
                                        : "Mark as done".tr(),
                                  ),
                                  PopupMenuItemData(
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.black54,
                                    ),
                                    title: "Share".tr(),
                                  ),
                                  PopupMenuItemData(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.black54,
                                    ),
                                    title: "Delete".tr(),
                                  )
                                ],
                                onPress: (index) async {
                                  switch (index) {
                                    case 0:
                                      await tasksVM
                                          .changeDoneAndSave(taskModel);
                                      break;
                                    case 1:
                                      String text =
                                          tasksVM.getTaskDataToShare(taskModel);
                                      await Share.share(text);
                                      break;
                                    case 2:
                                      await tasksVM
                                          .deleteTaskAndSave(taskModel);
                                      break;
                                  }
                                }),
                            Text(
                              taskModel.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: currTheme(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextsContentInfo(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      info: [
                        "${DateFormat("dd/MM/yyyy").format(taskModel.noteDate)}",
                        "${DateFormat().add_jm().format(taskModel.noteDate)}",
                      ],
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                initiallyExpanded: false,
                trailing: Text(
                  "${subtasks.length}/${subtasks.where((x) => x.isDone).length}",
                  maxLines: 1,
                  style: TextStyle(
                    color: currTheme(context).textTheme.bodySmall!.color,
                  ),
                ),
                title: Text(
                  'Subtasks'.tr(),
                  maxLines: 1,
                  style: TextStyle(
                    color: currTheme(context).textTheme.bodySmall!.color,
                  ),
                ),
                onExpansionChanged: (value) {
                  tasksVM.updateExpanstion(taskModel);
                },
                children: List.generate(
                  subtasks.length > 2 ? 2 : subtasks.length,
                  (index) => SubtaskListTile(
                    subtaskModel: subtasks[index],
                    maxLines: 1,
                    onCheckChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  double getHeight(int count) {
    double height = 70;
    if (count == 1) {
      return height * 1.7;
    } else if (count >= 2) {
      return height * 2.5;
    }

    return height;
  }
}
