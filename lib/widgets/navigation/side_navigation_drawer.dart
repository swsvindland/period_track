import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/utils/constants.dart';

import '../../services/sign_in.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      data: const ListTileThemeData(
        selectedColor: secondaryLight,
        iconColor: secondary,
        textColor: secondary,
      ),
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset('images/logo-alt.png', height: 36),
                    const SizedBox(width: 16),
                    Text(AppLocalizations.of(context)!.periodTrack,
                        style: const TextStyle(fontSize: 24, color: text)),
                  ],
                ),
              ),
            ),
            ListTile(
              selected: selectedIndex == 0,
              title: Text(AppLocalizations.of(context)!.calendar),
              leading: const Icon(Icons.calendar_today),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 1,
              title: Text(AppLocalizations.of(context)!.notes),
              leading: const Icon(Icons.note_add),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 2,
              title: Text(AppLocalizations.of(context)!.statistics),
              leading: const Icon(Icons.insights),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 3,
              title: Text(AppLocalizations.of(context)!.settings),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 4,
              title: Text(AppLocalizations.of(context)!.about),
              leading: const Icon(Icons.info),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                onItemTapped(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 5,
              title: Text(AppLocalizations.of(context)!.logOut),
              leading: const Icon(Icons.logout),
              onTap: () {
                signOut();
                navigatorKey.currentState!
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
