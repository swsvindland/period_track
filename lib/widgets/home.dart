import 'package:flutter/material.dart';
import 'package:period_track/widgets/calendar_key.dart';
import 'package:period_track/widgets/home_desktop.dart';
import 'package:period_track/widgets/home_mobile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../utils/constants.dart';
import 'calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < sm) {
      return HomeMobile();
    }

    return HomeDesktop();
  }
}
