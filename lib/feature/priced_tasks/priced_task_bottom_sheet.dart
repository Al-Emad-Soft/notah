import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notah/feature/priced_tasks/models/priced_task_model.dart';
import 'package:notah/feature/priced_tasks/widgets/priced_subtask.dart';
import 'package:notah/view_models/priced_tasks_view_model.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/funtions/custom_bottom_sheet_title.dart';
import 'package:notah/widgets/date_and_time_info_content.dart';

Future<dynamic> PricedTaskBottomSheet({
  required BuildContext context,
  required Function() onSave,
  required PricedTaskModel initModel,
}) {
  final _listController = ScrollController();
  return showCustomTaskBottomSheetTitled(
    context: context,
    initTitle: initModel.name,
    child: Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Consumer<PricedTasksViewModel>(
          builder: (context, vm, child) {
            return ListView(
              controller: _listController,
              physics: ClampingScrollPhysics(),
              shrinkWrap: false,
              children: [
                DateAndTimeInfoContents(
                  onDateSaved: (x) {
                    vm.changeMainTaskDate(x);
                  },
                  onTimeSaved: (x) {
                    vm.changeMainTaskTime(x);
                  },
                  infoText: "Products".tr() + ": ${vm.currentSubtasks.length}",
                  dateText: DateFormat("dd/MM/yyyy")
                      .format(vm.currentMainTask!.noteDate),
                  timeText: DateFormat()
                      .add_jm()
                      .format(vm.currentMainTask!.noteDate),
                ),
                Padding(
                  padding: const EdgeInsets.all(9),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final subtask = vm.currentSubtasks[index];
                      return PricedSubtask(
                        model: subtask,
                        onPriceChanged: (value) {
                          vm.changeSubtaskPrice(index, value);
                        },
                        onQtyChanged: (value) {
                          vm.changeSubtaskQty(index, value);
                        },
                        onNameChanged: (value) {
                          vm.changeSubtaskName(index, value);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: vm.currentSubtasks.length,
                    shrinkWrap: true,
                  ),
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
                            vm.addNewSubtask();
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
            );
          },
        ),
      ),
    ),
    onSave: (newTitle) {
      if (newTitle.isEmpty) {
        return;
      }
      context.read<PricedTasksViewModel>().changeMainTaskName(newTitle);
      context.read<PricedTasksViewModel>().saveCurrentTask();
      Navigator.pop(context);
    },
  );
}
