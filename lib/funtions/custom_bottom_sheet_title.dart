import 'package:flutter/material.dart';
import 'package:notah/funtions/show_custom_bottom_sheet.dart';
import 'package:notah/widgets/custom_task_title.dart';

Future<dynamic> showCustomTaskBottomSheetTitled({
  required BuildContext context,
  final int? titleLength,
  String? initTitle,
  required Widget child,
  final double? height = 500,
  required void Function(String) onSave,
}) {
  return showCustomTaskBottomSheet(
    context: context,
    height: height,
    child: Column(
      children: [
        CustomTaskTitle(
          titleLength: titleLength,
          title: initTitle ?? "",
          onSave: (newTitle) {
            onSave(newTitle);
          },
        ),
        child,
      ],
    ),
  );
}
