import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:period_track/widgets/delete_account.dart';

import '../models/preferences.dart';
import '../utils/constants.dart';
import 'app_bar_ad.dart';
import 'default_cycle.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          width: sm.toDouble(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                preferences.adFree || MediaQuery.of(context).size.width < md
                    ? const SizedBox(height: 0)
                    : const AppBarAd(),
                MediaQuery.of(context).size.width > md
                    ? const SizedBox(height: 36)
                    : const SizedBox(height: 0),
                const DefaultCycle(),
                const SizedBox(height: 16),
                const DeleteAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
