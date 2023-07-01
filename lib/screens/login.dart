import 'package:flutter/material.dart';
import '../obj/ui.dart';
import '../database/auth.dart';

class Login extends StatefulWidget {
  final UIComponents ui;
  const Login({super.key, required this.ui});

  @override
  State<Login> createState() => _LoginState(ui);
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late UIComponents ui;
  TextEditingController emailsignup = TextEditingController();
  TextEditingController passwordsignup = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  _LoginState(UIComponents ui) {
    this.ui = ui;
  }
  void startSignIn()async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the popup by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loading'),
          content: Row(
            children: [
              CircularProgressIndicator(), // Loading indicator
              SizedBox(width: 16.0),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
    if (useremail.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields'),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context).pop();
      return;
    }
    await signIn(useremail.text, password.text).then((value) {
      if (value == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign in successful'),
          duration: Duration(seconds: 2),
        ));
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/home');
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value.toString()),
          duration: Duration(seconds: 2),
        ));
        Navigator.of(context).pop();
      }
    });
  }

  void startSignUp() async{
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the popup by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loading'),
          content: Row(
            children: [
              CircularProgressIndicator(), // Loading indicator
              SizedBox(width: 16.0),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
    if (name.text.isEmpty ||
        emailsignup.text.isEmpty ||
        passwordsignup.text.isEmpty ||
        confirmpassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields'),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context).pop();
      return;
    }

    if (passwordsignup.text != confirmpassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match'),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context).pop();
      return;
    }

    await signUp(emailsignup.text, passwordsignup.text, name.text).then((value) {
      if (value == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign up successful'),
          duration: Duration(seconds: 2),
        ));
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value.toString()),
          duration: Duration(seconds: 2),
        ));
        Navigator.of(context).pop();
      }
    });
    
  }

  void _showSignUp() {
    Future.delayed(Duration(milliseconds: 100), () {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          enableDrag: false,
          isScrollControlled: false,
          anchorPoint: Offset(1, 0),
          elevation: 5,
          backgroundColor: Colors.transparent,
          transitionAnimationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 1000)),
          isDismissible: false,
          //showDragHandle: true,
          context: context,
          builder: (ctx) => signUpSheet());
    });
  }

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _showSignIn() {
    Future.delayed(Duration(milliseconds: 100), () {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          enableDrag: false,
          isScrollControlled: false,
          anchorPoint: Offset(1, 0),
          elevation: 5,
          backgroundColor: Colors.transparent,
          transitionAnimationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 1000)),
          isDismissible: false,
          //showDragHandle: true,
          context: context,
          builder: (ctx) => signInSheeet());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffE1BA48),
        body: Container(
          padding: EdgeInsets.only(top: 100),
          alignment: Alignment.topCenter,
          child: Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/textlogoblackpng.png'),
                    fit: BoxFit.contain)),
          ),
        ));
  }

  StatefulBuilder signInSheeet() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: 500,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Container(
            //alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ui.primarySwatch,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),

            padding: EdgeInsets.all(50),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: ui.textcolor),
                      'Sign in',
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            ui.changeTheme();
                          });
                        },
                        icon: Icon(
                          ui.isDark ? Icons.wb_sunny : Icons.nightlight_round,
                          color: ui.textcolor,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text('New User? ',
                        style: TextStyle(fontSize: 14, color: ui.textcolor)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showSignUp();
                        },
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffE1BA48)),
                        ))
                  ],
                ),
                TextField(
                    cursorColor: Color(0xffE1BA48),
                    style: TextStyle(
                      color: ui.textcolor,
                    ),
                    controller: useremail,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ui.textcolor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE1BA48),
                        ),
                      ),
                      hintText: 'Email address ',
                      hintStyle: TextStyle(color: ui.textcolor),
                    )),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    obscureText: _obscureText,
                    cursorColor: Color(0xffE1BA48),
                    style: TextStyle(
                      color: ui.textcolor,
                    ),
                    controller: password,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ui.textcolor,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffE1BA48),
                          ),
                        ),
                        hintText: 'password ',
                        hintStyle: TextStyle(color: ui.textcolor),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: _obscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ))),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffE1BA48)),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffE1BA48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          startSignIn();
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: ui.textcolor),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  StatefulBuilder signUpSheet() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: 700,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Container(
            //alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ui.primarySwatch,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),

            padding: EdgeInsets.all(50),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: ui.textcolor),
                      'Sign up',
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            ui.changeTheme();
                          });
                        },
                        icon: Icon(
                          ui.isDark ? Icons.wb_sunny : Icons.nightlight_round,
                          color: ui.textcolor,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text('Existing user? ',
                        style: TextStyle(fontSize: 14, color: ui.textcolor)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showSignIn();
                        },
                        child: Text(
                          'Sign in to your account',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffE1BA48)),
                        ))
                  ],
                ),
                TextField(
                    cursorColor: Color(0xffE1BA48),
                    style: TextStyle(
                      color: ui.textcolor,
                    ),
                    controller: name,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ui.textcolor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE1BA48),
                        ),
                      ),
                      hintText: 'Name ',
                      hintStyle: TextStyle(color: ui.textcolor),
                    )),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    cursorColor: Color(0xffE1BA48),
                    style: TextStyle(
                      color: ui.textcolor,
                    ),
                    controller: emailsignup,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ui.textcolor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE1BA48),
                        ),
                      ),
                      hintText: 'Email address ',
                      hintStyle: TextStyle(color: ui.textcolor),
                    )),
                TextField(
                    obscureText: _obscureText,
                    cursorColor: Color(0xffE1BA48),
                    style: TextStyle(
                      color: ui.textcolor,
                    ),
                    controller: passwordsignup,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ui.textcolor,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffE1BA48),
                          ),
                        ),
                        hintText: 'password ',
                        hintStyle: TextStyle(color: ui.textcolor),
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xffE1BA48),
                            )))),
                TextField(
                    obscureText: _obscureText2,
                    cursorColor: Color(0xffE1BA48),
                    style: TextStyle(
                      color: ui.textcolor,
                    ),
                    controller: confirmpassword,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ui.textcolor,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffE1BA48),
                          ),
                        ),
                        hintText: 'confirm password ',
                        hintStyle: TextStyle(color: ui.textcolor),
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xffE1BA48),
                            )))),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffE1BA48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        startSignUp();
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(color: ui.textcolor),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
