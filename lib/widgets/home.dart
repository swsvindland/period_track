import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';

import '../models/preferences.dart';
import 'calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    var user = Provider.of<User?>(context);

    return StreamProvider<Preferences>.value(
      initialData: Preferences.empty(),
      value: db.streamPreferences(user!.uid),
      catchError: (_, err) => Preferences.empty(),
      child: const Calendar()
    );
  }
}
