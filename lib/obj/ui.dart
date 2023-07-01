import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LightTheme {
  MaterialColor primarySwatch = const MaterialColor(0xffF3EDF7, <int, Color>{
    50: Color(0xffF3EDF7),
    100: Color(0xffF3EDF7),
    200: Color(0xffF3EDF7),
    300: Color(0xffF3EDF7),
    400: Color(0xffF3EDF7),
    500: Color(0xffF3EDF7),
    600: Color(0xffF3EDF7),
    700: Color(0xffF3EDF7),
    800: Color(0xffF3EDF7),
    900: Color(0xffF3EDF7),
  });

  MaterialColor background = const MaterialColor(0xffFEF7FF, <int, Color>{
    50: Color(0xffFEF7FF),
    100: Color(0xffFEF7FF),
    200: Color(0xffFEF7FF),
    300: Color(0xffFEF7FF),
    400: Color(0xffFEF7FF),
    500: Color(0xffFEF7FF),
    600: Color(0xffFEF7FF),
    700: Color(0xffFEF7FF),
    800: Color(0xffFEF7FF),
    900: Color(0xffFEF7FF),
  });
  Brightness brightness = Brightness.light;
  Color secondary = Color(0xff4D4D4D);
  Color textcolor = Color(0xff4D4D4D);
  Color selectioncolor = Color(0xffE8DEF8);
  Color splash = Color(0xff20466A);
  Color switchon = Color(0xff4D4D4D);
  Color switchoff = Color(0x884D4D4D);
  Color yellow = Color(0xffA78521);
}

class DarkTheme {
  MaterialColor primarySwatch = const MaterialColor(0xff2B2930, <int, Color>{
    50: Color(0xff2B2930),
    100: Color(0xff2B2930),
    200: Color(0xff2B2930),
    300: Color(0xff2B2930),
    400: Color(0xff2B2930),
    500: Color(0xff2B2930),
    600: Color(0xff2B2930),
    700: Color(0xff2B2930),
    800: Color(0xff2B2930),
    900: Color(0xff2B2930),
  });
  MaterialColor background = const MaterialColor(0xff141218, <int, Color>{
    50: Color(0xff141218),
    100: Color(0xff141218),
    200: Color(0xff141218),
    300: Color(0xff141218),
    400: Color(0xff141218),
    500: Color(0xff141218),
    600: Color(0xff141218),
    700: Color(0xff141218),
    800: Color(0xff141218),
    900: Color(0xff141218),
  });
  Brightness brightness = Brightness.dark;
  Color secondary = Color(0xffE1BA48);
  Color textcolor = Color(0xffFEF7FF);
  Color selectioncolor = Color(0xff4A4458);
  Color splash = Color(0xff000F21);
  Color switchon = Color(0xffE1BA48);
  Color switchoff = Color(0x88E1BA48);
  Color yellow = Color(0xffE1BA48);
}

class UIComponents {
  late SharedPreferences prefs;
  DarkTheme darkTheme = DarkTheme();
  LightTheme lightTheme = LightTheme();
  Future init() async {
    prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    isDark = !isDark;
    //print(isDark);
    changeTheme();
  }

  late MaterialColor primarySwatch;
  late MaterialColor background;
  late Brightness brightness;
  late Color textcolor;
  late Color selectioncolor;
  late bool isDark;
  late Color slide;
  late Color switchon;
  late Color switchoff;
  late Color secondary;
  late Color yellow ;
  Future changeTheme() async {
    if (isDark) {
      primarySwatch = lightTheme.primarySwatch;
      background = lightTheme.background;
      brightness = lightTheme.brightness;
      textcolor = lightTheme.textcolor;
      selectioncolor = lightTheme.selectioncolor;
      slide = lightTheme.splash;
      switchon = lightTheme.switchon;
      switchoff = lightTheme.switchoff;
      secondary = lightTheme.secondary;
      yellow = lightTheme.yellow;
      isDark = false;
    } else {
      primarySwatch = darkTheme.primarySwatch;
      background = darkTheme.background;
      brightness = darkTheme.brightness;
      textcolor = darkTheme.textcolor;
      selectioncolor = darkTheme.selectioncolor;
      slide = darkTheme.splash;
      switchon = darkTheme.switchon;
      switchoff = darkTheme.switchoff;
      secondary = darkTheme.secondary;
      yellow = darkTheme.yellow;
      isDark = true;
    }

    await prefs.setBool('isDark', isDark);
  }
  //var theme = DarkTheme();
}
