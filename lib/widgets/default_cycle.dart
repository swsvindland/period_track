import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/preferences.dart';
import '../utils/colors.dart';

class DefaultCycle extends StatefulWidget {
  const DefaultCycle({Key? key}) : super(key: key);

  @override
  State<DefaultCycle> createState() => _DefaultCycleState();
}

class _DefaultCycleState extends State<DefaultCycle> {
  final db = DatabaseService();
  late int defaultCycleLength;
  bool set = false;
  late TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  void update(User? user, Preferences preferences) {
    preferences.setDefaultCycleLength(int.parse(controller.text));
    set = false;

    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    setState(() {
      if (!set) {
        defaultCycleLength = preferences.defaultCycleLength;
        controller.text = preferences.defaultCycleLength.toString();
      }
    });

    return Card(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.defaultLength,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    update(user, preferences);
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: primaryDark),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.update,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
