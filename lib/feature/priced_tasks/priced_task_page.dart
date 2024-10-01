// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notah/feature/priced_tasks/models/priced_task_model.dart';
import 'package:notah/feature/priced_tasks/priced_task_bottom_sheet.dart';
import 'package:notah/feature/priced_tasks/widgets/priced_card.dart';
import 'package:notah/view_models/priced_tasks_view_model.dart';
import 'package:notah/widgets/custom_floating_action_button.dart';
import 'package:provider/provider.dart';

class PricedTaskPage extends StatelessWidget {
  const PricedTaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Consumer<PricedTasksViewModel>(
                  builder: (context, vm, child) {
                    if (vm.mainTasks.isEmpty) return Center();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: vm.mainTasks.length,
                      itemBuilder: (context, index) {
                        return PricedCard(
                          model: vm.mainTasks[index].copyWith(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: true,
            child: CustomFloatingActionButton(
              onPressed: () {
                context.read<PricedTasksViewModel>().addNewMainTask();
                PricedTaskBottomSheet(
                  context: context,
                  onSave: () {},
                  initModel: PricedTaskModel(noteDate: DateTime.now()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
