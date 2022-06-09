import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/widgets/app_bar_ad.dart';
import 'package:period_track/widgets/navigation_drawer.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/utils/constants.dart';

import '../models/note.dart';
import '../models/preferences.dart';
import '../widgets/home.dart';
import '../widgets/notes.dart';
import '../widgets/reports.dart';
import '../widgets/settings.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({Key? key}) : super(key: key);

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
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
      return const CircularProgressIndicator();
    }

    return Scaffold(
      body: MultiProvider(
        providers: [
          StreamProvider<Preferences>.value(
              initialData: Preferences.empty(),
              value: db.streamPreferences(user.uid),
              catchError: (_, err) => Preferences.empty()),
          StreamProvider<Iterable<NoteModel>>.value(
            initialData: const [],
            value: db.streamNotes(user.uid),
            catchError: (_, err) => [],
          ),
        ],
        child: Row(
          children: [
            NavigationDrawer(
                selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
            Expanded(
              child: Center(
                child: _selectedIndex == 0
                    ? const Home()
                    : _selectedIndex == 1
                        ? const Notes()
                        : _selectedIndex == 2
                            ? const Reports()
                            : const Settings(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/add-note', arguments: {
            "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
          });
        },
        icon: const Icon(Icons.note_add),
        label: const Text('New Entry'),
      ),
    );
  }
}