import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final double radius;
  final Icon icon;
  final Color? backgroudColor;
  final double? elevation;
  const CustomIconButton({
    super.key,
    this.radius = 40,
    this.elevation,
    this.backgroudColor,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      color: backgroudColor,
      onPressed: onPressed,
      child: icon,
      minWidth: radius,
      height: radius,
      shape: CircleBorder(),
    );
  }
}
