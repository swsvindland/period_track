import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    var user = Provider.of<User?>(context);

    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('TODO: Reports')
      ),
    );
  }
}
