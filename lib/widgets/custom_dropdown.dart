import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final Function(T?)? onChanged;
  final Widget Function(int) itemBuilder;
  const CustomDropdown({
    Key? key,
    required this.items,
    this.value,
    required this.onChanged,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownButton<T>(
        underline: Center(),
        value: value,
        padding: EdgeInsets.symmetric(horizontal: 10),
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        items: List<DropdownMenuItem<T>>.generate(
          items.length,
          (index) => DropdownMenuItem<T>(
            child: itemBuilder(index),
            value: items[index],
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
