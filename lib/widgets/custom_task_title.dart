// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';

import 'package:notah/widgets/custom_icon_button.dart';

class CustomTaskTitle extends StatefulWidget {
  final String title;
  final Function(String) onSave;
  final int? titleLength;
  CustomTaskTitle({
    Key? key,
    required this.title,
    required this.onSave,
    this.titleLength,
  }) : super(key: key);

  @override
  State<CustomTaskTitle> createState() => _CustomTaskTitleState();
}

class _CustomTaskTitleState extends State<CustomTaskTitle> {
  String? _errorText = null;
  late String newTitle;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newTitle = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Theme(
                data: currTheme(context),
                child: TextFormField(
                  scrollPadding: EdgeInsets.zero,
                  maxLines: 1,
                  initialValue: widget.title,
                  maxLength: widget.titleLength,
                  onChanged: (value) {
                    newTitle = value;
                  },
                  validator: (value) {
                    return _errorText;
                  },
                  //decoration: ,
                  decoration: InputDecoration(
                    errorText: _errorText,
                    hintText: 'Title'.tr(),
                  ),
                  style: currTheme(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomIconButton(
              icon: Icon(
                Icons.check,
                color: currTheme(context).iconTheme.color,
              ),
              onPressed: () {
                widget.onSave(newTitle);

                setState(() {
                  if (newTitle.isEmpty) {
                    _errorText = "Title is empty".tr();
                  } else {
                    _errorText = null;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
