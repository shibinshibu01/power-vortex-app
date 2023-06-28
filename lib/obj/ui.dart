import 'package:flutter/material.dart';

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
  
}

class UIComponents {
  var theme = LightTheme();
}
