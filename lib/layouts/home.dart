import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/layouts/home_desktop.dart';
import 'package:period_track/layouts/home_mobile.dart';
import 'package:period_track/layouts/home_tablet.dart';
import 'package:provider/provider.dart';
import 'package:period_track/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (MediaQuery.of(context).size.width < sm) {
      return const HomePageMobile();
    }

    if (MediaQuery.of(context).size.width < md) {
      return const HomePageTablet();
    }

    return const HomePageDesktop();
  }
}

enum Popup { about, logOut }
