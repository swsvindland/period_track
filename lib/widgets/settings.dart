import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/widgets/delete_account.dart';

import '../models/preferences.dart';
import '../utils/constants.dart';
import 'default_cycle.dart';
import 'notifications.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var db = DatabaseService();

    return StreamProvider<Preferences>.value(
      initialData: Preferences.empty(),
      value: db.streamPreferences(user!.uid),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: SizedBox(
            width: sm.toDouble(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                DefaultCycle(),
                SizedBox(height: 16),
                Notifications(),
                SizedBox(height: 16),
                DeleteAccount()
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
