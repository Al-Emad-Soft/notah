import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/widgets/widgets_content_info.dart';

class DateAndTimeInfoContents extends StatelessWidget {
  final String dateText;
  final String timeText;
  final String infoText;
  final Function(DateTime) onDateSaved;
  final Function(TimeOfDay) onTimeSaved;

  const DateAndTimeInfoContents({
    Key? key,
    required this.dateText,
    required this.timeText,
    required this.infoText,
    required this.onDateSaved,
    required this.onTimeSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetsContentInfo(
      info: [
        Text(
          style: currTheme(context).textTheme.labelSmall,
          infoText,
        ),
        Text(
          style: currTheme(context).textTheme.labelSmall,
          "|",
        ),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1999),
                  lastDate: DateTime(3000),
                );
                if (selectedDate == null) return;
                onDateSaved(selectedDate);
              },
              icon: Icon(Icons.calendar_month),
            ),
            Text(
              dateText,
              style: currTheme(context).textTheme.labelSmall,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime == null) return;
                onTimeSaved(selectedTime);
              },
              icon: Icon(Icons.timer_outlined),
            ),
            Text(
              timeText,
              style: currTheme(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}
