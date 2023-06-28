import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Color textcolor = Colors.black;
  Color selectioncolor = Color(0xffE8DEF8);
  Color splash = Color(0xff20466A);
}

class DarkTheme {
  MaterialColor primarySwatch = const MaterialColor(0xff211F26, <int, Color>{
    50: Color(0xff211F26),
    100: Color(0xff211F26),
    200: Color(0xff211F26),
    300: Color(0xff211F26),
    400: Color(0xff211F26),
    500: Color(0xff211F26),
    600: Color(0xff211F26),
    700: Color(0xff211F26),
    800: Color(0xff211F26),
    900: Color(0xff211F26),
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
  Color textcolor = Colors.white;
  Color selectioncolor = Color(0xff4A4458);
  Color splash = Color(0xff000F21);
}

class UIComponents {
  late SharedPreferences prefs;
  DarkTheme darkTheme = DarkTheme();
  LightTheme lightTheme = LightTheme();
  Future init() async {
    prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    print(isDark);
    changeTheme();
  }

  UIComponents() {
    init();
    
  }
  late MaterialColor primarySwatch;
  late MaterialColor background;
  late Brightness brightness;
  late Color textcolor;
  late Color selectioncolor;
  late bool isDark;

  Future changeTheme() async {
    
    if (isDark) {
      primarySwatch = lightTheme.primarySwatch;
      background = lightTheme.background;
      brightness = lightTheme.brightness;
      textcolor = lightTheme.textcolor;
      selectioncolor = lightTheme.selectioncolor;
      isDark = false;
    } else {
      primarySwatch = darkTheme.primarySwatch;
      background = darkTheme.background;
      brightness = darkTheme.brightness;
      textcolor = darkTheme.textcolor;
      selectioncolor = darkTheme.selectioncolor;
      isDark = true;
    }
    
    await prefs.setBool('isDark', isDark);
  }
  //var theme = DarkTheme();
}
