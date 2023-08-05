import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';

Future<dynamic> showCustomTaskBottomSheet({
  required BuildContext context,
  final int? titleLength,
  final double? height = 500,
  required Widget child,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        top: 15,
        right: 15,
        left: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 15,
      ),
      child: Container(
        constraints: BoxConstraints.expand(height: height),
        decoration: BoxDecoration(
          color: currTheme(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    ),
  );
}
