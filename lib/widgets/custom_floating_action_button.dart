import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;
  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      height: 50,
      width: 60,
      left: (MediaQuery.of(context).size.width / 2) - 30,
      child: FloatingActionButton(
        backgroundColor: currTheme(context).primaryColor,
        child: Icon(
          Icons.add,
          color: currTheme(context).iconTheme.color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
