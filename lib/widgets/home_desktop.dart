import 'package:flutter/material.dart';
import 'package:period_track/widgets/calendar_key.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../utils/constants.dart';
import 'calendar.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  bool drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Calendar(),
            const SizedBox(height: 24),
            const Divider(color: Color(0xffFFBB7C)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                navigatorKey.currentState!.pushNamed('/add-note', arguments: {
                  "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.note_add),
                  SizedBox(width: 8),
                  Text(
                    'New Entry',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).brightness == Brightness.light ? const Color(0xffD6A5B3) : Theme.of(context).cardColor,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 600,
                  child: CalendarKey(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
