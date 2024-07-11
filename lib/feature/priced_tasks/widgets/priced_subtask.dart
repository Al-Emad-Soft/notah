// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:notah/feature/priced_tasks/models/priced_task_model.dart';
import 'package:notah/widgets/custom_icon_button.dart';

class PricedSubtask extends StatelessWidget {
  final PricedTaskModel model;
  final TextEditingController _nameController = TextEditingController();
  final Function(int value) onPriceChanged;
  final Function(int value) onQtyChanged;
  final Function(String value) onNameChanged;
  PricedSubtask({
    Key? key,
    required this.model,
    required this.onPriceChanged,
    required this.onQtyChanged,
    required this.onNameChanged,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    _nameController.text = model.name.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomIconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            SizedBox(
              width: 5,
            ),
            Flexible(
              flex: 2,
              child: new TextFormField(
                controller: _nameController,
                onChanged: (value) {
                  onNameChanged(value);
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                maxLines: 1,
                minLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              flex: 1,
              child: new TextFormField(
                initialValue: model.price.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {
                  if (value.isEmpty) {
                    value = "0";
                  }
                  final price = int.tryParse(value);
                  if (price != null) onPriceChanged(price);

                  print(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            CustomIconButton(
              onPressed: () {
                onQtyChanged(model.qty - 1);
              },
              icon: Icon(Icons.remove_outlined),
            ),
            Text(model.qty.toString()),
            CustomIconButton(
              onPressed: () {
                onQtyChanged(model.qty + 1);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text((model.qty * model.price).toString()),
        ),
      ],
    );
  }
}
