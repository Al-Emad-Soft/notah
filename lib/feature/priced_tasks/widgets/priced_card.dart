import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notah/feature/priced_tasks/models/priced_task_model.dart';
import 'package:notah/feature/priced_tasks/priced_task_bottom_sheet.dart';
import 'package:notah/view_models/priced_tasks_view_model.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/models/popup_menu_item_data.dart';
import 'package:notah/widgets/custom_popup_menu.dart';
import 'package:notah/widgets/text_content_info.dart';

class PricedCard extends StatelessWidget {
  final PricedTaskModel model;
  const PricedCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Consumer<PricedTasksViewModel>(builder: (context, vm, child) {
      return Card(
        borderOnForeground: false,
        clipBehavior: Clip.antiAlias,
        color: currTheme(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            vm.getMainTaskDetailsById(model.id);
            PricedTaskBottomSheet(
              context: context,
              onSave: () {},
              initModel: vm.currentMainTask!,
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
                              onPress: (x) {},
                              items: [
                                // PopupMenuItemData(
                                //   icon: Icon(
                                //     true
                                //         ? Icons.check_box
                                //         : Icons.check_box_rounded,
                                //     color: true
                                //         ? Colors.green[900]
                                //         : Colors.black54,
                                //   ),
                                //   title: true
                                //       ? "Unmark as done".tr()
                                //       : "Mark as done".tr(),
                                // ),
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
                              // onPress: (index) async {
                              //   switch (index) {
                              //     case 0:
                              //       await tasksVM.changeDoneAndSave(taskModel);
                              //       break;
                              //     case 1:
                              //       String text =
                              //           tasksVM.getTaskDataToShare(taskModel);
                              //       await Share.share(text);
                              //       break;
                              //     case 2:
                              //       await tasksVM.deleteTaskAndSave(taskModel);
                              //       break;
                              //   }
                              // },
                            ),
                            Text(
                              model.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: currTheme(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Text(
                          model.totalPrice.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: currTheme(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    TextsContentInfo(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      info: [
                        "${DateFormat("dd/MM/yyyy").format(model.noteDate)}",
                        "${DateFormat().add_jm().format(model.noteDate)}",
                      ],
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                initiallyExpanded: false,
                trailing: Text(
                  //"${subtasks.length}/${subtasks.where((x) => x.isDone).length}",
                  model.name,
                  maxLines: 1,
                  style: TextStyle(
                    color: currTheme(context).textTheme.bodySmall!.color,
                  ),
                ),
                title: Text(
                  'Products'.tr(),
                  maxLines: 1,
                  style: TextStyle(
                    color: currTheme(context).textTheme.bodySmall!.color,
                  ),
                ),
                onExpansionChanged: (value) {
                  // tasksVM.updateExpanstion(taskModel);
                },
                children: List.generate(
                  //subtasks.length > 2 ? 2 : subtasks.length,
                  3,
                  (index) => Text(index.toString()),
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
