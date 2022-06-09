import 'package:flutter/material.dart';
import 'package:period_track/widgets/calendar_key.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
      minHeight: 56,
      maxHeight: 200,
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          width: MediaQuery.of(context).size.width,
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
            children: const [
              SizedBox(height: 24),
              Calendar(),
              SizedBox(height: 24),
              Divider(color: Color(0xffFFBB7C)),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
