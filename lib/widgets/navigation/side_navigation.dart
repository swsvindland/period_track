import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/colors.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      extended: true,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/logo-alt.png', height: 36),
            const SizedBox(width: 16),
            Text(AppLocalizations.of(context)!.periodTrack,
                style: const TextStyle(fontSize: 24, color: text)),
          ],
        ),
      ),
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.calendar_today),
          label: Text(AppLocalizations.of(context)!.calendar),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.note_add),
          label: Text(AppLocalizations.of(context)!.notes),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.insights),
          label: Text(AppLocalizations.of(context)!.statistics),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.settings),
          label: Text(AppLocalizations.of(context)!.settings),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.info),
          label: Text(AppLocalizations.of(context)!.about),
        ),
        NavigationRailDestination(
            padding: const EdgeInsets.all(8),
            icon: const Icon(Icons.logout),
            label: Text(AppLocalizations.of(context)!.logOut)),
      ],
    );
  }
}
