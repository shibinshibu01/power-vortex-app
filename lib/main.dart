import 'package:flutter/material.dart';
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
        '/home': (context) => Body(ui: ui),
        '/login':(context) => Login(ui: ui),
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
  Body({super.key, required this.ui});

  @override
  State<Body> createState() => _BodyState(ui);
}

class _BodyState extends State<Body> {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  UIComponents ui;
  _BodyState(this.ui);
  PageController _pageController = PageController();
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _pageIndex == 1
            ? FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: ui.selectioncolor,
                onPressed: () {})
            : null,
        backgroundColor: ui.background,
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
              trailing:Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image(image: AssetImage('assets/logotext.png')),
                  ), 
                
                drawerIconColor: ui.textcolor,
                appBarColor: ui.background,
                title: Text('')
                        ),
            slider: Container(
              alignment: Alignment.center,
              color: ui.primarySwatch,
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: ui.selectioncolor,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/logotransparent.png'),
                    ),
                  ),
                  slideOption('Settings', Icons.settings),
                  slideOption('About', Icons.info),
                  slideOption('Logout', Icons.logout),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.brightness_3,
                      color: ui.textcolor,
                    ),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: ui.textcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                      // inactiveThumbColor: ui.textcolor,
                      // activeThumbImage: AssetImage('assets/moon.png'),
                      // activeColor: ui.textcolor,
                      // inactiveThumbImage: AssetImage('assets/sun.png'),
                      activeColor: ui.textcolor,
                      value: ui.isDark,
                      onChanged: (value) => setState(() {
                        ui.changeTheme();
                      }),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: ui.yellow,
                    ),
                    title: TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Logged out'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: ui.textcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: ui.background,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  Home(ui: ui),
                  Schedule(ui: ui),
                  DashBoard(ui: ui),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GNav(
          gap: 5,
          tabMargin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          tabActiveBorder: Border.all(color: ui.textcolor, width: 0.2),
          padding: EdgeInsets.all(10),
          tabBackgroundColor: ui.secondary,
          backgroundColor: ui.primarySwatch,
          color: ui.textcolor,
          activeColor: ui.background,
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

  ListTile slideOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: ui.textcolor,
      ),
      title: Text(title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: ui.textcolor)),
      // onTap: () => setState(() {
      //   _pageIndex = index;
      //   _pageController.animateToPage(index,
      //       duration: Duration(milliseconds: 300),
      //       curve: Curves.ease);

      // }),
    );
  }
}
