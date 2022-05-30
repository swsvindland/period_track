import 'package:flutter/material.dart';
import 'package:period_track/widgets/calendar_key.dart';
import 'calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 24),
            Calendar(),
            SizedBox(height: 24),
            Divider(color: Color(0xffFFBB7C)),
            SizedBox(height: 24),
            CalendarKey()
          ],
        ),
      ),
    );
  }
}
