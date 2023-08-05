// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';

import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/notes/custom_task_grid_bottom_sheet.dart';
import 'package:notah/feature/notes/models/note_task_model.dart';
import 'package:notah/feature/notes/note_card.dart';
import 'package:notah/feature/notes_folders/tasks_folders_view_model.dart';
import 'package:notah/funtions/show_custom_bottom_sheet.dart';
import 'package:notah/view_models/notes_view_model.dart';
import 'package:notah/widgets/custom_floating_action_button.dart';
import 'package:notah/widgets/custom_icon_button.dart';
import 'package:notah/widgets/custom_material_button.dart';
import 'package:notah/widgets/custom_selection_panel_button.dart';

import 'note_header.dart';

class NotesTasksPage extends StatelessWidget {
  const NotesTasksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Consumer<NotesTasksViewModel>(
        builder: (context, tasksVM, child) => Stack(
          children: [
            Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: SizedBox(
                          height: 40,
                          child: NoteTasksHeader(),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Consumer<TasksFoldersViewModel>(
                            builder: (context, foldersVM, child) {
                              final favoTasks = tasksVM.getFolderFavoTasks(
                                  foldersVM.getCurrentFolderId());
                              return Visibility(
                                visible: favoTasks.length > 0,
                                child: ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Text(
                                    "Favorites".tr(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 30, top: 10),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: getGridCount(context),
                                        ),
                                        itemCount: favoTasks.length,
                                        itemBuilder: (context, i) =>
                                            TaskGridTile(
                                          taskModel: favoTasks[i],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Consumer<TasksFoldersViewModel>(
                        builder: (context, foldersVM, child) {
                          final notFavoTasks = tasksVM.getFolderNotFavoTasks(
                              foldersVM.getCurrentFolderId());
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: getGridCount(context)),
                            itemCount: notFavoTasks.length,
                            itemBuilder: (context, i) => TaskGridTile(
                              taskModel: notFavoTasks[i],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BottomSelectionPanel(tasksVM: tasksVM),
              ],
            ),
            Visibility(
              visible: !tasksVM.isSelectionMode,
              child: CustomFloatingActionButton(
                onPressed: () {
                  showGridTasksBottomSheet(
                    context: context,
                    onSave: () {},
                    initTask: NoteTaskModel(noteDate: DateTime.now()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSelectionPanel extends StatelessWidget {
  final NotesTasksViewModel tasksVM;
  const BottomSelectionPanel({
    Key? key,
    required this.tasksVM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: tasksVM.isSelectionMode ? 1 : 0,
      duration: Duration(milliseconds: 100),
      child: Visibility(
        visible: tasksVM.isSelectionMode,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
              color: currTheme(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSelectionPanelButton(
                  icon: Icon(
                    Icons.delete_outline_outlined,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actionsPadding: EdgeInsets.all(5),
                        title: Text(
                          "Delete Alert".tr(),
                          style: currTheme(context).textTheme.titleMedium,
                        ),
                        content: Text(
                          "Are you sure to delete all selected notes?".tr(),
                          style: currTheme(context).textTheme.bodySmall,
                        ),
                        actions: [
                          CustomIconButton(
                            radius: 60,
                            onPress: () async {
                              await tasksVM.deleteSelectedTasks();
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                          CustomIconButton(
                            radius: 60,
                            onPress: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Consumer<TasksFoldersViewModel>(
                  builder: (context, foldersVM, child) =>
                      CustomSelectionPanelButton(
                    icon: Icon(
                      Icons.folder_copy_outlined,
                    ),
                    onPressed: () {
                      showCustomTaskBottomSheet(
                        context: context,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomMaterialButton(
                                      text: "All".tr(),
                                      onPressed: () async {
                                        await tasksVM
                                            .changeSelectedTasksFolder(-1);

                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    foldersVM.allfolders.length,
                                    (i) {
                                      final folder = foldersVM.allfolders[i];
                                      return CustomMaterialButton(
                                        text: folder.title,
                                        onPressed: () async {
                                          await tasksVM
                                              .changeSelectedTasksFolder(
                                                  folder.id);

                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomSelectionPanelButton(
                  icon: Icon(
                    color: tasksVM.isSelectionFavo
                        ? Colors.red
                        : currTheme(context).iconTheme.color,
                    tasksVM.isSelectionFavo
                        ? Icons.favorite_outlined
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    tasksVM.changeSelectedFavorite();
                  },
                ),
                CustomSelectionPanelButton(
                  icon: Icon(
                    Icons.exit_to_app,
                  ),
                  onPressed: () {
                    tasksVM.clearSelections();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int getGridCount(BuildContext context) {
  num size = MediaQuery.of(context).size.width;
  int res = size ~/ 170;
  return res < 1 ? 1 : res;
}
