import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/widgets/app_bar_ad.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/note.dart';
import '../models/preferences.dart';
import '../widgets/about.dart';
import '../widgets/home/home.dart';
import '../widgets/navigation/side_navigation_drawer.dart';
import '../widgets/notes.dart';
import '../widgets/reports/reports.dart';
import '../widgets/settings.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({Key? key}) : super(key: key);

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
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
    var preferences = Provider.of<Preferences>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: preferences.adFree ? const Text('PeriodTrack') : const AppBarAd(),
        elevation: 0,
      ),
      drawer: SideNavigationDrawer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: MultiProvider(
        providers: [
          StreamProvider<Iterable<NoteModel>>.value(
            initialData: const [],
            value: db.streamNotes(user.uid),
            catchError: (_, err) => [],
          ),
        ],
        child: _selectedIndex == 0
            ? const Home()
            : _selectedIndex == 1
                ? const Notes()
                : _selectedIndex == 2
                    ? const Reports()
                    : _selectedIndex == 3
                        ? const Settings()
                        : const About(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/add-note', arguments: {
            "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
          });
        },
        icon: const Icon(Icons.note_add),
        label: Text(AppLocalizations.of(context)!.newEntry),
      ),
    );
  }
}

enum Popup { about, logOut }
