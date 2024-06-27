import 'package:flutter/material.dart';
import 'custom_icon_button.dart';

class CustomSelectionPanelButton extends StatelessWidget {
  final Function() onPressed;
  final Icon icon;
  const CustomSelectionPanelButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      radius: 50,
      icon: icon,
    );
  }
}
