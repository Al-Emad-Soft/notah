// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';

class CustomChip extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool isSelected;
  const CustomChip({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: currTheme(context).primaryColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: Center(child: child),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        //   color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),

        side: isSelected
            ? BorderSide(color: Colors.orangeAccent)
            : BorderSide.none,
      ),
    );
  }
}
