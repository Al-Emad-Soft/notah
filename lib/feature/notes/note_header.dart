import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/notes_folders/task_folder_model.dart';
import 'package:notah/feature/notes_folders/tasks_folders_view_model.dart';
import 'package:notah/funtions/custom_bottom_sheet_title.dart';
import 'package:notah/view_models/notes_view_model.dart';
import 'package:notah/widgets/custom_chip.dart';
import 'package:notah/widgets/custom_icon_button.dart';
import 'package:notah/widgets/text_content_info.dart';

class NoteTasksHeader extends StatelessWidget {
  const NoteTasksHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesTasksViewModel>(
      builder: (context, tasksVM, child) => Row(
        children: [
          Consumer<TasksFoldersViewModel>(
            builder: (context, foldersVM, child) {
              final tasks =
                  tasksVM.getFolderTasks(foldersVM.getCurrentFolderId()).length;
              final favoCount = tasksVM
                  .getFolderFavoTasks(foldersVM.getCurrentFolderId())
                  .length;
              return TextsContentInfo(
                mainAxisAlignment: MainAxisAlignment.start,
                fontSize: 15,
                info: ["Notes".tr() + ": ${tasks}/${favoCount}"],
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Consumer<TasksFoldersViewModel>(
              builder: (context, foldersVM, child) => ListView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                children: [
                  CustomChip(
                    child: Text(
                      "All".tr(),
                      style: currTheme(context).textTheme.titleSmall,
                    ),
                    isSelected: foldersVM.currentFolder == null,
                    onTap: () {
                      foldersVM.setSelectedFolder(null);
                    },
                  ),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: foldersVM.allfolders.length,
                    itemBuilder: (context, index) {
                      final folder = foldersVM.allfolders[index];
                      return CustomChip(
                        isSelected: foldersVM.checkFolderIsSelected(folder),
                        child: Text(
                          folder.title,
                          style: currTheme(context).textTheme.titleSmall,
                        ),
                        onTap: () {
                          foldersVM.setSelectedFolder(folder);
                        },
                        onLongPress: tasksVM.isSelectionMode
                            ? null
                            : () {
                                showFoldersBottomSheet(
                                  context: context,
                                  folderModel: folder,
                                  initTitle: folder.title,
                                  onDelete: () async {
                                    if (await tasksVM
                                        .deleteFolderTasks(folder.id)) {
                                      await foldersVM.deleteFolder(folder);
                                      Navigator.pop(context);
                                    }
                                  },
                                  onSave: (newTitle) async {
                                    if (newTitle.isEmpty) return;

                                    folder.title = newTitle;
                                    await foldersVM.saveFolder(folder);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                      );
                    },
                  ),
                  CustomChip(
                    child: Icon(
                      Icons.folder_open,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      showFoldersBottomSheet(
                          context: context,
                          onSave: (title) async {
                            if (title.isEmpty) return;

                            await foldersVM
                                .saveFolder(TaskFolderModel(title: title));
                            Navigator.pop(context);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showFoldersBottomSheet(
      {required BuildContext context,
      TaskFolderModel? folderModel,
      String? initTitle,
      Function(String)? onSave,
      Function()? onDelete,
      required}) {
    return showCustomTaskBottomSheetTitled(
      titleLength: 12,
      initTitle: initTitle,
      context: context,
      height: folderModel == null ? 100 : 200,
      child: folderModel != null
          ? CustomIconButton(
              onPressed: () {
                if (onDelete != null) {
                  onDelete();
                }
              },
              radius: 100,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 50,
              ),
            )
          : Center(),
      onSave: (newTitle) {
        if (onSave != null) {
          onSave(newTitle);
        }
      },
    );
  }
}
