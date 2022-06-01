import 'package:flutter/material.dart';
import 'package:period_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about, style: const TextStyle(color: Colors.white)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: sm.toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Designed By',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                const Text(
                  'Charlena Kea',
                  style: TextStyle(color: textColor, fontSize: 12),
                ),
                const SizedBox(height: 36),
                const Text(
                  'Built By',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                const Text(
                  'Samuel Svindland',
                  style: TextStyle(color: textColor, fontSize: 12),
                ),
                const SizedBox(height: 36),
                Text(
                  AppLocalizations.of(context)!.aboutPageVersion,
                  style: const TextStyle(color: textColor, fontSize: 16),
                ),
                const Text(
                  '1.0.0',
                  style: TextStyle(color: textColor, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
