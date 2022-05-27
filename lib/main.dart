import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:period_track/layouts/layouts.dart';
import 'package:period_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
            initialData: FirebaseAuth.instance.currentUser,
            value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: MaterialApp(
        title: 'PeriodTrack',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          // Locale('es', ''), // Spanish
          // Locale('pt', ''), // Portuguese
          // Locale('fr', ''), // French
          // Locale('de', ''), // German
          // Locale('it', ''), // Italian
          // Locale('zh', ''), // Simplified Chinese
          // Locale('ko', ''), // Korean
          // Locale('ja', ''), // Japanese
          // Locale('ar', ''), // Arabic
          // Locale('hi', ''), // Hindi
        ],
        theme: ThemeData(
            colorSchemeSeed: Colors.pink,
            brightness: Brightness.light,
            useMaterial3: true,
            backgroundColor: Colors.pink,
            scaffoldBackgroundColor: Colors.pink,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white)),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.pink,
            brightness: Brightness.dark,
            useMaterial3: true,
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black, foregroundColor: Colors.white)),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashscreenPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/about': (context) => const AboutPage(),
        },
      ),
    );
  }
}
