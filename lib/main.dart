import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:period_track/layouts/layouts.dart';
import 'package:period_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MobileAds.instance.initialize();

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
          colorSchemeSeed: const Color(0xffac6d7e),
          brightness: Brightness.light,
          useMaterial3: true,
          backgroundColor: const Color(0xffac6d7e),
          scaffoldBackgroundColor: const Color(0xffac6d7e),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffac6d7e),
            foregroundColor: Color(0xffFFBB7C),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xff63465A),
            unselectedItemColor: Color(0xffFFBB7C),
            selectedItemColor: Color(0xffE3E3A7),
          ),
          cardTheme: const CardTheme(color: Color(0xffFFF3E8)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xffFFF3E8),
              foregroundColor: Color(0xff323232)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 35)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffFFF3E8)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffFFF3E8)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xffac6d7e),
          brightness: Brightness.dark,
          useMaterial3: true,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        themeMode: ThemeMode.dark,
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
