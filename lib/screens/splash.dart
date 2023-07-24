import 'dart:async';
import 'dart:io';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:powervortex/global.dart';
import 'package:powervortex/obj/objects.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import '../obj/ui.dart';
import 'login.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../database/collections.dart';


class Splash extends StatefulWidget {
  final UIComponents ui;
  Splash({Key? key, required this.ui}) : super(key: key);

  @override
  _SplashState createState() => _SplashState(ui);
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  late UIComponents ui;
  _SplashState(UIComponents ui) {
    this.ui = ui;
  }

  Future<Widget> futureCall() async {
    ///ui = UIComponents();
    await ui.init();
    await auth.authStateChanges().listen((User? user) async {
      currentuser = user;
      userdetails = UserDetails(
        name: user!.displayName!,
        email: user.email!,
        uid: user.uid,
      );
    });
    uic = ui;
    await Future.delayed(Duration(seconds: 3));
    listenForConsumptionChanges();
    if (auth.currentUser != null&&auth.currentUser!.emailVerified) {
      if (auth.currentUser!.photoURL == null) {
        image = Image.asset('assets/user.png');
      } else
      image = Image.network(auth.currentUser!.photoURL!,fit: BoxFit.cover,height: 150,
                          width: 150,);
      await getHomeDetails(0);
      return Future.value(new Body());
    }
    return Future.value(new Login(ui: ui));
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
