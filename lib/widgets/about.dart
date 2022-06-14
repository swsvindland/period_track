import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:period_track/utils/colors.dart';

import '../utils/constants.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: sm.toDouble(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.aboutPageCreditsDesigned,
                style: const TextStyle(color: text, fontSize: 16),
              ),
              const Text(
                'Charlena Kea',
                style: TextStyle(color: text, fontSize: 12),
              ),
              const SizedBox(height: 36),
              Text(
                AppLocalizations.of(context)!.aboutPageCreditsBuilt,
                style: const TextStyle(color: text, fontSize: 16),
              ),
              const Text(
                'Samuel Svindland',
                style: TextStyle(color: text, fontSize: 12),
              ),
              const SizedBox(height: 36),
              Text(
                AppLocalizations.of(context)!.aboutPageVersion,
                style: const TextStyle(color: text, fontSize: 16),
              ),
              const Text(
                '1.0.0',
                style: TextStyle(color: text, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
