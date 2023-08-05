import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/tasks/custom_task_list_bottom_sheet.dart';
import 'package:notah/feature/tasks/subtask_list_tile.dart';
import 'package:notah/models/popup_menu_item_data.dart';
import 'package:notah/view_models/todos_view_model.dart';
import 'package:notah/widgets/custom_icon_button.dart';
import 'package:notah/widgets/custom_popup_menu.dart';
import 'package:notah/widgets/text_content_info.dart';
import 'package:share_plus/share_plus.dart';

import 'models/todo_task_model.dart';

// ignore: must_be_immutable
class CustomTaskListTile extends StatelessWidget {
  final TodoTaskModel taskModel;
  CustomTaskListTile({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosViewModel>(builder: (context, tasksVM, child) {
      final subtasks = tasksVM.getSubtasks(taskModel);
      taskModel.copyFrom(tasksVM.getTaskById(taskModel.id));
      return Card(
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
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeOut,
            onEnd: () {},
            height: taskModel.isFolded ? 80 : getHeight(subtasks.length),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                        await Share.share("test share task");
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
                          CustomIconButton(
                            onPress: () async {
                              await tasksVM.changeFoldAndSave(taskModel);
                            },
                            icon: Icon(
                              taskModel.isFolded
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up,
                              color: currTheme(context).iconTheme.color,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      TextsContentInfo(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        info: [
                          "${subtasks.length}/${subtasks.where((x) => x.isDone).length}",
                          "${DateFormat("dd/MM/yyyy").format(taskModel.noteDate)}",
                          "${DateFormat().add_jm().format(taskModel.noteDate)}",
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !taskModel.isFolded,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemBuilder: (context, index) => SubtaskListTile(
                          subtaskModel: subtasks[index],
                          maxLines: 1,
                          onCheckChanged: (value) {},
                        ),
                        itemCount: subtasks.length > 2 ? 2 : subtasks.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
