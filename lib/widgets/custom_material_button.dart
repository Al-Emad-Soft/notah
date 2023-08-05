import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';

class CustomMaterialButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  const CustomMaterialButton({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: currTheme(context).textTheme.bodyMedium,
        ),
        height: 100,
        onPressed: onPressed,
        color: currTheme(context).buttonTheme.colorScheme!.background,
      ),
    );
  }
}
