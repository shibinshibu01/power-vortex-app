import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/home.dart';
import 'obj/ui.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(Vortex());
}

class Vortex extends StatelessWidget {
  
  Vortex({super.key});
  UIComponents ui = UIComponents();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power Vortex',
      routes: {
        '/': (context) => Splash(),
        //'/second': (context) => const SecondPage(title: 'Second Page'),
        '/home': (context) => Body()
      },
      theme: ThemeData(
        primarySwatch: ui.theme.primarySwatch,
        // colorScheme: ColorScheme(
        //   secondary: ui.theme.primarySwatch,
        //   onSecondary: ui.theme.primarySwatch,
        //   onPrimary: ui.theme.primarySwatch,
        //   primary: ui.theme.primarySwatch,
        //   background: ui.theme.background,
        // brightness: ui.theme.brightness,
        // error: Colors.yellow,
        // onBackground: ui.theme.background,
        // onError: Colors.yellow,
        // onSurface: ui.theme.background,
        // surface: 
        // ),
      ),
      initialRoute: '/',
      //home: const MyHomePage(title: 'Vortex'),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UIComponents ui = UIComponents();
  PageController _pageController = PageController();
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: PageView(
          controller: _pageController,
          children: [
            home,
            home,
            home,],
          ),
        bottomNavigationBar:GNav(
          tabMargin: EdgeInsets.symmetric( horizontal: 4,vertical: 10),
          tabActiveBorder: Border.all(color: ui.theme.textcolor, width: 0.2),
          padding: EdgeInsets.all(10),
          tabBackgroundColor: ui.theme.selectioncolor,
          backgroundColor: ui.theme.primarySwatch,
          color: ui.theme.textcolor,
          activeColor: ui.theme.textcolor,
          onTabChange: (value) => setState(() {
            _pageIndex = value;
            _pageController.animateToPage(value,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.timer,
              text: 'Schedule',
            ),
            GButton(
              icon: Icons.dashboard,
              text: 'Dashboard',
            ),

          ],
          selectedIndex: _pageIndex,
        )
    );
  }
}