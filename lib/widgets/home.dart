import 'package:flutter/material.dart';
import 'package:period_track/widgets/home_desktop.dart';
import 'package:period_track/widgets/home_mobile.dart';
import '../utils/constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < sm) {
      return const HomeMobile();
    }

    return const HomeDesktop();
  }
}
