import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<Widget> futureCall() async {
    // do async operation ( api call, auto login)
    await Future.delayed(Duration(seconds: 3));
    return Future.value(new Body());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      //backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      futureNavigator: futureCall(),
    );
  }
}
