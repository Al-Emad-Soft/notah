import 'package:flutter/material.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';

import 'models/todo_task_model.dart';

class SubtaskListTile extends StatelessWidget {
  final TodoTaskModel subtaskModel;
  final int? maxLines;
  final bool editable;
  final Function(bool?)? onCheckChanged;
  final Function()? onDelete;
  final _textController = TextEditingController();
  SubtaskListTile(
      {super.key,
      this.maxLines,
      this.editable = false,
      required this.subtaskModel,
      this.onCheckChanged,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    _textController.text = subtaskModel.content;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: editable ? 0 : 5,
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: Colors.green,
            checkColor: currTheme(context).iconTheme.color,
            onChanged: onCheckChanged,
            value: subtaskModel.isDone,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: !editable
                ? Text(
                    subtaskModel.content,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                : TextFormField(
                    controller: _textController,
                    onChanged: (value) {
                      subtaskModel.content = value;
                    },
                    enabled: editable,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      hintText: "Content".tr(),
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
          ),
          Visibility(
            visible: editable,
            child: MaterialButton(
              onPressed: onDelete,
              child: Icon(
                Icons.delete,
              ),
              minWidth: 40,
              height: 40,
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
