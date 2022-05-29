import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/utils/constants.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.MMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: textColor,),
            onPressed: onLeftArrowTap,
          ),
          Text(
              headerText,
              style: const TextStyle(fontSize: 32.0, color: textColor),
            ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: textColor,),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}