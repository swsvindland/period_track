import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/layouts/home_desktop.dart';
import 'package:period_track/layouts/home_mobile.dart';
import 'package:period_track/layouts/home_tablet.dart';
import 'package:period_track/widgets/app_bar_ad.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/services/sign_in.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/navigation/navigation_bottom.dart';
import 'package:period_track/widgets/navigation/navigation_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/note.dart';
import '../models/preferences.dart';
import '../widgets/home.dart';
import '../widgets/notes.dart';
import '../widgets/reports.dart';
import '../widgets/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
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
