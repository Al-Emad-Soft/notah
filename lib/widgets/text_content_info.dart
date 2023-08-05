// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';

class TextsContentInfo extends StatelessWidget {
  final List<String> info;
  final double fontSize;

  final MainAxisAlignment mainAxisAlignment;
  TextsContentInfo({
    Key? key,
    required this.info,
    this.fontSize = 12,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(
        info.length,
        (index) => Text(
          info[index],
          style: currTheme(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
