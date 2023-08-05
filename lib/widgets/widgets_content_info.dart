// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetsContentInfo extends StatelessWidget {
  final List<Widget> info;
  final MainAxisAlignment mainAxisAlignment;
  WidgetsContentInfo({
    Key? key,
    required this.info,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(
        info.length,
        (index) => info[index],
      ),
    );
  }
}
