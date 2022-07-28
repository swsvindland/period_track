import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:period_track/widgets/reports/flow_length.dart';
import 'package:provider/provider.dart';

import '../../models/preferences.dart';
import '../../utils/constants.dart';
import '../app_bar_ad.dart';
import 'cycle_length.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          preferences.adFree || MediaQuery.of(context).size.width < md
              ? const SizedBox(height: 0)
              : const AppBarAd(),
          MediaQuery.of(context).size.width > md
              ? const SizedBox(height: 36)
              : const SizedBox(height: 0),
          Center(
            child: SizedBox(
              height: 350,
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.periodLength,
                      ),
                      subtitle: const SizedBox(height: 275, child: CycleLength()),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 350,
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.flowLength,
                      ),
                      subtitle: const SizedBox(height: 275, child: FlowLength()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
