// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';

import 'package:notah/feature/notes/custom_task_grid_bottom_sheet.dart';
import 'package:notah/feature/notes/models/note_task_model.dart';
import 'package:notah/models/popup_menu_item_data.dart';
import 'package:notah/view_models/notes_view_model.dart';
import 'package:notah/widgets/custom_popup_menu.dart';
import 'package:notah/widgets/text_content_info.dart';
import 'package:share_plus/share_plus.dart';

class TaskGridTile extends StatelessWidget {
  final NoteTaskModel taskModel;
  final Function()? onPressed;
  final Function()? onLongPress;
  TaskGridTile({
    Key? key,
    required this.taskModel,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesTasksViewModel>(builder: (context, tasksVM, child) {
      bool isSelected = tasksVM.checkSelectedTask(taskModel);
      return Transform.scale(
        scale: isSelected ? 0.93 : 1,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: currTheme(context).primaryColor,
          shape: RoundedRectangleBorder(
            side: !taskModel.favorite
                ? BorderSide.none
                : BorderSide(
                    width: 1,
                    color: Colors.redAccent,
                  ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onLongPress: () {
              if (!tasksVM.isSelectionMode) {
                tasksVM.selectTask(taskModel);
              }
            },
            onTap: () {
              if (tasksVM.isSelectionMode) {
                tasksVM.selectTask(taskModel);
                return;
              }

              if (onPressed != null) {
                onPressed!();
              }
              showGridTasksBottomSheet(
                initTask: taskModel,
                context: context,
                onSave: () {},
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          taskModel.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: currTheme(context).textTheme.titleMedium,
                        ),
                      ),
                      Visibility(
                        visible: !tasksVM.isSelectionMode,
                        child: CustomPopupMenuButton(
                          items: [
                            PopupMenuItemData(
                              icon: Icon(
                                taskModel.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: taskModel.favorite
                                    ? Colors.red[900]
                                    : Colors.black54,
                              ),
                              title: "Favorite".tr(),
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
                                color: Colors.black54,
                                Icons.delete,
                              ),
                              title: "Delete".tr(),
                            ),
                          ],
                          onPress: (index) async {
                            switch (index) {
                              case 0:
                                await tasksVM.changeFavorite(task: taskModel);
                                break;
                              case 1:
                                final text =
                                    tasksVM.getNoteDataToShare(taskModel);
                                await Share.share(text);
                                break;
                              case 2:
                                await tasksVM.deleteNoteTaskById(
                                    id: taskModel.id);
                                break;
                            }
                          },
                        ),
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
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 6,
                      taskModel.content,
                      style: currTheme(context).textTheme.bodySmall,
                    ),
                  ),
                  Visibility(
                    visible: tasksVM.isSelectionMode,
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: isSelected ? Colors.green : Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
