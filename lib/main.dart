
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_app/screens/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:group_app/screens/main_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('he')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('he'),
      child: MyApp()
  ),);
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    FirebaseAnalytics analytics = FirebaseAnalytics();
    final materialTheme = new ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, //  <-- dark color
          textTheme: ButtonTextTheme
              .primary, //  <-- this auto selects the right color
        ),
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white
    );
    final materialDarkTheme = new ThemeData(
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey, //  <-- dark color
          textTheme: ButtonTextTheme
              .primary, //  <-- this auto selects the right color
        ),
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.black
    );

    final cupertinoTheme = new CupertinoThemeData(
      brightness: brightness, // if null will use the system theme
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: Colors.purple,
        darkColor: Colors.cyan,
      ),
    );
    FirebaseAuth auth = FirebaseAuth.instance;
    return Theme(
      data: brightness == Brightness.light ? materialTheme : materialDarkTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(
          platformStyle: PlatformStyleData(
            android: PlatformStyle.Cupertino,
          ),
        ),
        builder: (context) => PlatformApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          initialRoute: auth.currentUser == null ? '/landing' : '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/landing': (context) => LandingPage(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/': (context) => MainPage(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales:  context.supportedLocales,
          locale: context.locale,
          title: 'GroupApp!',
          material: (_, __) {
            return new MaterialAppData(
              theme: materialTheme,
              darkTheme: materialDarkTheme,
              themeMode: brightness == Brightness.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
          },
          cupertino: (_, __) => new CupertinoAppData(
            theme: cupertinoTheme,
          ),
        ),
      ),
    );

  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformText(tr("SOMETHING_WENT_WRONG")),
    );
  }
}

