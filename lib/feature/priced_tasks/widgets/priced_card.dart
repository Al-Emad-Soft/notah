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

  PricedCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Consumer<PricedTasksViewModel>(
      builder: (context, vm, child) {
        final List<PricedTaskModel> subtasks =
            vm.getCurrentSubtasks(mainTask: model);

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
            child: SingleChildScrollView(
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
                                  // onPress: (x) {},
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
                                  onPress: (index) async {
                                    switch (index) {
                                      case 1:
                                        await vm.deleteTaskAndSave(model);
                                        break;
                                    }
                                  },
                                ),
                                Text(
                                  model.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:
                                      currTheme(context).textTheme.titleMedium,
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
                      trailing: SizedBox(),
                      title: Text(
                        'Products'.tr(),
                        maxLines: 1,
                        style: TextStyle(
                          color: currTheme(context).textTheme.bodySmall!.color,
                        ),
                      ),
                      onExpansionChanged: (value) {
                        vm.toggleSubtasks(model.id);
                        vm.getMainTaskDetailsById(model.id);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Name'.tr(),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Price'.tr(),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Qty'.tr(),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        ...List.generate(
                          subtasks.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 3, child: Text(subtasks[index].name)),
                                Expanded(
                                  flex: 2,
                                  child: Text((subtasks[index].price *
                                          subtasks[index].qty)
                                      .toString()),
                                ),
                                Expanded(
                                    child:
                                        Text(subtasks[index].qty.toString())),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        );
      },
    );
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
