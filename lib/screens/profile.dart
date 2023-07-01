import 'package:flutter/material.dart';
import 'package:powervortex/obj/objects.dart';
import '../global.dart';
import '../database/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: uic.yellow,
            ),
          ),
          elevation: 0,
          title: Text(
            'Profile',
            style: TextStyle(
                color: uic.yellow, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          backgroundColor: uic.primarySwatch,
          actions: [
            //changetheme
            IconButton(
              onPressed: () {
                setState(() {
                  uic.changeTheme();
                });
              },
              icon: Icon(
                  uic.isDark
                      ? Icons.brightness_5_outlined
                      : Icons.brightness_4_outlined,
                  color: uic.textcolor),
            )
          ],
        ),
        backgroundColor: uic.primarySwatch,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                  backgroundColor: uic.yellow,
                  minRadius: 75,
                  maxRadius: 80,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: uic.background,
                    child: ClipOval(
                        child: Icon(
                      Icons.person,
                      size: 140,
                    )),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              currentuser!.displayName!,
              style: TextStyle(
                  color: uic.textcolor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            //SizedBox(height: 20,),
            Text(
              currentuser!.email!,
              style: TextStyle(
                  color: uic.textcolor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: uic.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: uic.primarySwatch,
                          title: Text('Alert! you are about to logout',
                              style: TextStyle(color: uic.textcolor)),
                          content: Text('Are you sure you want to log out?',
                              style: TextStyle(color: uic.textcolor)),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: uic.yellow),
                                )),
                            TextButton(
                                onPressed: () async {
                                  await signOut().then((value) {
                                    if (value == 'Success') {
                                      Navigator.pushNamed(context, '/login');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(value),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      });

                  //Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(color: uic.background, fontSize: 18),
                )),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text('My Buildings',
                  style: TextStyle(
                      color: uic.textcolor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: userdetails.homes.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return index == userdetails.homes.length
                        ? GestureDetector(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: uic.background,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: uic.yellow,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Add Building',
                                    style: TextStyle(
                                        color: uic.textcolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              //show modelbottomsheet
                              showModalBottomSheet(
                                  backgroundColor: uic.isDark
                                      ? uic.yellow
                                      : uic.primarySwatch,
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (context) {
                                    return addBuildingSheet(context);
                                  });
                            },
                          )
                        : Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: uic.background,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: uic.yellow,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Building ${index + 1}',
                                  style: TextStyle(
                                      color: uic.textcolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                  }),
            )
          ],
        ));
  }

  Container addBuildingSheet(BuildContext context) {
    return Container(
      height: 600,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: uic.isDark ? uic.yellow : uic.primarySwatch,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          height: 500,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Add Building',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Building Name',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Building Name',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
              
              ElevatedButton(onPressed: (){

                
              }, child: Text('Add Building'),style: ElevatedButton.styleFrom(
                primary: uic.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
