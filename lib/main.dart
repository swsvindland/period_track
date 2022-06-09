import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:period_track/layouts/layouts.dart';
import 'package:period_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase_options.dart';
import 'layouts/add_note.dart';

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
          textTheme: GoogleFonts.josefinSansTextTheme(),
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
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xff63465A),
          ),
          navigationRailTheme: const NavigationRailThemeData(
            backgroundColor: Color(0xff63465A),
            selectedLabelTextStyle: TextStyle(color: Color(0xffE3E3A7)),
            selectedIconTheme: IconThemeData(color: Color(0xffE3E3A7)),
            unselectedLabelTextStyle: TextStyle(color: Color(0xffFFBB7C)),
            unselectedIconTheme: IconThemeData(color: Color(0xffFFBB7C)),
            useIndicator: false,
          ),
          cardTheme: const CardTheme(color: Color(0xffECCDD6)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: callToAction, foregroundColor: primaryDarkColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(primaryDarkColor),
              backgroundColor: MaterialStateProperty.all<Color>(callToAction),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(primaryDarkColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: callToAction),
              ),
            ),
          ),
          dialogBackgroundColor: const Color(0xffECCDD6),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xffac6d7e),
          brightness: Brightness.dark,
          useMaterial3: true,
          textTheme: GoogleFonts.josefinSansTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme),
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            unselectedItemColor: Color(0xffFFBB7C),
            selectedItemColor: Color(0xffE3E3A7),
          ),
          navigationRailTheme: const NavigationRailThemeData(
            selectedLabelTextStyle: TextStyle(color: Color(0xffE3E3A7)),
            selectedIconTheme: IconThemeData(color: Color(0xffE3E3A7)),
            unselectedLabelTextStyle: TextStyle(color: Color(0xffFFBB7C)),
            unselectedIconTheme: IconThemeData(color: Color(0xffFFBB7C)),
            useIndicator: false,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff7c2946)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffffd9e2)),
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              foregroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffffd9e2)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: Color(0xff7c2946)),
              ),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashscreenPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/about': (context) => const AboutPage(),
          '/add-note': (context) => AddNotePage()
        },
      ),
    );
  }
}
