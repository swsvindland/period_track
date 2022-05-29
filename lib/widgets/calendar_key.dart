import 'package:flutter/material.dart';
import 'package:period_track/utils/constants.dart';

class CalendarKey extends StatelessWidget {
  const CalendarKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: const [
        CalendarKeyItem(text: 'cycle begins'),
        CalendarKeyItem(text: 'predicted ovulation'),
        CalendarKeyItem(text: 'period'),
        CalendarKeyItem(text: 'predicted fertile days'),
        CalendarKeyItem(text: 'intimacy'),
        CalendarKeyItem(text: 'notes'),
      ],
    );
  }
}

class CalendarKeyItem extends StatelessWidget {
  const CalendarKeyItem({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 20,
      child: Row(
      children: [
        const CircleAvatar(backgroundColor: Color(0xff989859), child: SizedBox(height: 16, width: 16,)),
        Text(text, style: const TextStyle(color: Color(0xffFFF3E8)),)
      ],
    ),
    );
  }
}
