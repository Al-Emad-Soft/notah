import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPress;
  final double radius;
  final Icon icon;
  final Color? backgroudColor;
  final double? elevation;
  const CustomIconButton({
    super.key,
    this.radius = 40,
    this.elevation,
    this.backgroudColor,
    required this.onPress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      color: backgroudColor,
      onPressed: onPress,
      child: icon,
      minWidth: radius,
      height: radius,
      shape: CircleBorder(),
    );
  }
}
