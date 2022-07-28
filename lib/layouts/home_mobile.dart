import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/widgets/app_bar_ad.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/services/sign_in.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/navigation/navigation_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/note.dart';
import '../models/preferences.dart';
import '../widgets/home/home.dart';
import '../widgets/notes.dart';
import '../widgets/reports/reports.dart';
import '../widgets/settings.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
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
        title:
            preferences.adFree ? const Text('PeriodTrack') : const AppBarAd(),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<Popup>(
            onSelected: (Popup result) {
              if (result == Popup.about) {
                navigatorKey.currentState!.pushNamed('/about');
              }
              if (result == Popup.logOut) {
                signOut();
                navigatorKey.currentState!
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Popup>>[
              PopupMenuItem<Popup>(
                value: Popup.about,
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(AppLocalizations.of(context)!.about),
                ),
              ),
              PopupMenuItem<Popup>(
                value: Popup.logOut,
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: Text(AppLocalizations.of(context)!.logOut),
                ),
              ),
            ].toList(),
          ),
        ],
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
                    : const Settings(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/add-note', arguments: {
            "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
          });
        },
        child: const Icon(Icons.note_add),
      ),
      bottomNavigationBar: NavigationBottom(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}

enum Popup { about, logOut }
