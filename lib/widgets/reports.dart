import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cycle_length.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
