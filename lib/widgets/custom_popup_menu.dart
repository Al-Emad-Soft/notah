// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/models/popup_menu_item_data.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Function(int) onPress;
  final List<PopupMenuItemData> items;
  CustomPopupMenuButton({
    super.key,
    required this.onPress,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: currTheme(context),
      child: PopupMenuButton<int>(
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onSelected: onPress,
        itemBuilder: (context) => List.generate(
            items.length,
            (index) => PopupMenuItem(
                  height: 30,
                  value: index,
                  child: Row(
                    children: [
                      items[index].icon,
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        items[index].title,
                        style: currTheme(context).popupMenuTheme.textStyle,
                      )
                    ],
                  ),
                )),
        offset: const Offset(0, 40),
        //color: currTheme(context).popupMenuTheme.color,
      ),
    );
  }
}
