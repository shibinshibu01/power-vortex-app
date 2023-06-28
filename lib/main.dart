import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/home.dart';
import 'obj/ui.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'screens/dashboard.dart';
import 'screens/schedule.dart';

void main() {
  runApp(Vortex());
}

class Vortex extends StatelessWidget {
  Vortex({super.key});
 // UIComponents ui = UIComponents();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power Vortex',
      routes: {
        '/': (context) => Splash(),
        //'/second': (context) => const SecondPage(title: 'Second Page'),
        //'/home': (context) => Body(ui:ui)
      },
      theme: ThemeData(
          // primarySwatch: ui.primarySwatch,
          // brightness: ui.brightness,
          // backgroundColor: ui.background,
          // scaffoldBackgroundColor: ui.background,
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
  UIComponents ui;
   Body({super.key,required this.ui});

  @override
  State<Body> createState() => _BodyState(ui);
}

class _BodyState extends State<Body> {
  UIComponents ui;
  _BodyState(this.ui);
  PageController _pageController = PageController();
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ui.background,
        appBar: AppBar(
          backgroundColor: ui.primarySwatch,
          leading: IconButton(
            icon: Icon(
              ui.isDark ? Icons.wb_sunny : Icons.nightlight_round,
              color: ui.textcolor,
            ),
            onPressed: () => setState(() {
              ui.changeTheme();
            }),
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            home(ui),
            schedule(ui),
            dashboard(ui),
          ],
        ),
        bottomNavigationBar: GNav(
          gap: 5,
          tabMargin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          tabActiveBorder: Border.all(color: ui.textcolor, width: 0.2),
          padding: EdgeInsets.all(10),
          tabBackgroundColor: ui.selectioncolor,
          backgroundColor: ui.primarySwatch,
          color: ui.textcolor,
          activeColor: ui.textcolor,
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
        ));
  }
}
