import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import '../obj/ui.dart';

class Splash extends StatefulWidget {
  final UIComponents ui;
  Splash({Key? key, required this.ui}) : super(key: key);

  @override
  _SplashState createState() => _SplashState(ui);
}

class _SplashState extends State<Splash> {
  late UIComponents ui;
  _SplashState(UIComponents ui) {
    this.ui = ui;
  }

  Future<Widget> futureCall() async {
    ///ui = UIComponents();
    await ui.init();
    await Future.delayed(Duration(seconds: 3));
    return Future.value(new Body(ui: ui));
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: Color(0xff1F2122),
      logo: Image.asset('assets/logotext.png'),

      //backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loaderColor: Color(0xffE1BA48),
      logoWidth: 200,
      loadingText: Text(
        "Loading...",
        style: TextStyle(color: Color(0xffE1BA48)),
      ),
      futureNavigator: futureCall(),
    );
  }
}
