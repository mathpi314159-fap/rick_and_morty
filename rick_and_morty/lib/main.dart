import 'package:flutter/material.dart';
import 'package:rick_and_morty/character/characterProvider.dart';
import 'package:rick_and_morty/character/characterScreenArguments.dart';
import 'package:rick_and_morty/homeScreen.dart';
import 'package:rick_and_morty/settings.dart';
import 'character/characterScreen.dart';
import 'episode/episodeProvider.dart';
import 'episode/episodeScreen.dart';
import 'episode/episodeScreenArguments.dart';
import 'location/locationProvider.dart';
import 'location/locationScreen.dart';
import 'location/locationScreenArguments.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Settings.appBarColor,
              titleTextStyle: TextStyle(color: Colors.white)),
        ),
        initialRoute: '/',
        routes: {Routes.toHome: (BuildContext context) => HomeScreen()},
        onGenerateRoute: (settings) {
          if (settings.name == CharacterScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) {
                final CharacterScreenArguments args =
                    settings.arguments as CharacterScreenArguments;
                return CharacterProvider(args.id);
              },
            );
          }

          if (settings.name == EpisodeScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) {
                final EpisodeScreenArguments args =
                settings.arguments as EpisodeScreenArguments;
                return EpisodeProvider(args.id);
              },
            );
          }

          if (settings.name == LocationScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) {
                final LocationScreenArguments args =
                settings.arguments as LocationScreenArguments;
                return LocationProvider(args.id);
              },
            );
          }
        });
  }
}

class Routes {
  static final toHome = '/';
}
