import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/app_bar_ad.dart';
import 'package:period_track/widgets/calendar/calendar_key.dart';
import 'package:provider/provider.dart';

import '../../models/preferences.dart';
import '../calendar/calendar.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  bool drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              preferences.adFree || MediaQuery.of(context).size.width < md
                  ? const SizedBox(height: 0)
                  : const AppBarAd(),
              const SizedBox(height: 24),
              const Calendar(),
              const SizedBox(height: 24),
              const SizedBox(
                width: 600,
                child: Divider(color: secondary),
              ),
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).brightness == Brightness.light
                    ? primaryAlt
                    : Theme.of(context).cardColor,
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
      ),
    );
  }
}
