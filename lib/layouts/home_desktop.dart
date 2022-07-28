import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/widgets/navigation/side_navigation.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/note.dart';
import '../services/sign_in.dart';
import '../widgets/about.dart';
import '../widgets/home/home.dart';
import '../widgets/notes.dart';
import '../widgets/reports/reports.dart';
import '../widgets/settings.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({Key? key}) : super(key: key);

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 5) {
      signOut();
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/login', (route) => false);
    }

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
          StreamProvider<Iterable<NoteModel>>.value(
            initialData: const [],
            value: db.streamNotes(user.uid),
            catchError: (_, err) => [],
          ),
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SideNavigation(
                selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
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
        label: Text(AppLocalizations.of(context)!.newEntry),
      ),
    );
  }
}
