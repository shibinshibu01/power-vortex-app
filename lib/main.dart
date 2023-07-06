import 'package:flutter/material.dart';
import 'package:powervortex/database/collections.dart';
import 'package:powervortex/global.dart';
import 'screens/splash.dart';
import 'screens/home.dart';
import 'obj/ui.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'screens/dashboard.dart';
import 'screens/schedule.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login.dart';
import 'screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Vortex());
}

class Vortex extends StatelessWidget {
  Vortex({super.key});
  UIComponents ui = UIComponents();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Power Vortex',
      routes: {
        '/': (context) => Splash(ui: ui),
        //'/second': (context) => const SecondPage(title: 'Second Page'),
        '/home': (context) => Body(),
        '/login': (context) => Login(ui: ui),
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
  Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  PageController _pageController = PageController();
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _pageIndex == 1
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.add),
                backgroundColor: uic.secondary,
                onPressed: () {})
            : null,
        backgroundColor: uic.background,
        // appBar: AppBar(
        //   backgroundColor: ui.primarySwatch,
        //   leading: IconButton(
        //     icon: Icon(
        //       ui.isDark ? Icons.wb_sunny : Icons.nightlight_round,
        //       color: ui.textcolor,
        //     ),
        //     onPressed: () => setState(() {
        //       ui.changeTheme();
        //     }),
        //   ),
        // ),
        body: SafeArea(
          child: SliderDrawer(
            key: _key,
            slideDirection: SlideDirection.RIGHT_TO_LEFT,
            appBar: SliderAppBar(
                trailing: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image(image: AssetImage('assets/logotext.png')),
                ),
                drawerIconColor: uic.textcolor,
                appBarColor: uic.background,
                title: Text('')),
            slider: Container(
              alignment: Alignment.center,
              color: uic.primarySwatch,
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: uic.selectioncolor,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/logotransparent.png'),
                    ),
                  ),
                  slideOption('Settings', Icons.settings, () {
                    getHomeDetails(0);
                  }),
                  slideOption('About', Icons.info, () {}),
                  slideOption('Profile', Icons.person, () {
                    Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()))
                        .then((value) {
                      setState(() {});
                    });
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.brightness_3,
                      color: uic.textcolor,
                    ),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: uic.textcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                      // inactiveThumbColor: ui.textcolor,
                      // activeThumbImage: AssetImage('assets/moon.png'),
                      // activeColor: ui.textcolor,
                      // inactiveThumbImage: AssetImage('assets/sun.png'),
                      activeColor: uic.textcolor,
                      value: uic.isDark,
                      onChanged: (value) => setState(() {
                        uic.changeTheme();
                      }),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Logged out'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    leading: Icon(
                      Icons.logout,
                      color: uic.yellow,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: uic.textcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: uic.background,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  Home(ui: uic),
                  Schedule(ui: uic),
                  DashBoard(ui: uic),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GNav(
          gap: 5,
          tabMargin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          tabActiveBorder: Border.all(color: uic.textcolor, width: 0.2),
          padding: EdgeInsets.all(10),
          tabBackgroundColor: uic.secondary,
          backgroundColor: uic.primarySwatch,
          color: uic.textcolor,
          activeColor: uic.background,
          onTabChange: (value) => setState(() {
            //print(currentuser!.email);

            _key.currentState!.closeSlider();
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

  ListTile slideOption(String title, IconData icon, void Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: uic.textcolor,
      ),
      title: Text(title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: uic.textcolor)),
      // onTap: () => setState(() {
      //   _pageIndex = index;
      //   _pageController.animateToPage(index,
      //       duration: Duration(milliseconds: 300),
      //       curve: Curves.ease);

      // }),
    );
  }
}
