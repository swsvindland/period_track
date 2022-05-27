import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/constants.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 600,
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarBuilders: CalendarBuilders(headerTitleBuilder: (context, day) {
          var text = DateFormat.MMMM().format(day);
          return Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 48, color: textColor),
            ),
          );
        }, dowBuilder: (context, day) {
          return const Center();
        }, todayBuilder: (context, day, day2) {
          return Center(
            child: Text(
              day.day.toString(),
              style: const TextStyle(
                  color: textColor, backgroundColor: primaryDarkColor),
            ),
          );
        }, defaultBuilder: (context, day, day2) {
          return Center(
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: textColor),
            ),
          );
        }, disabledBuilder: (context, day, day2) {
          return const Center();
        }),
      ),
    );
  }
}
