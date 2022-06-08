import 'package:flutter/material.dart';
import 'package:period_track/widgets/calendar_key.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../utils/constants.dart';
import 'calendar.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  bool drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: Theme.of(context).brightness == Brightness.light ? const Color(0xffD6A5B3) : Theme.of(context).cardColor,
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(8), bottom: Radius.zero),
      minHeight: 36,
      maxHeight: 200,
      padding: const EdgeInsets.all(8),
      onPanelOpened: () {
        setState(() {
          drawerOpen = true;
        });
      },
      onPanelClosed: () {
        setState(() {
          drawerOpen = false;
        });
      },
      header: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Center(
            child: drawerOpen
                ? const Icon(Icons.keyboard_arrow_down)
                : const Icon(Icons.keyboard_arrow_up),
          )),
      panel: const Center(
        child: CalendarKey(),
      ),
      body: Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
