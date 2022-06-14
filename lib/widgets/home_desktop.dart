import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/widgets/calendar_key.dart';
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
            const Divider(color: secondary),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).brightness == Brightness.light ? primaryAlt : Theme.of(context).cardColor,
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
