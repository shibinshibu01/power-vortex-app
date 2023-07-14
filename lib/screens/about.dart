import 'package:flutter/material.dart';
import 'package:powervortex/global.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  //fn to show bottom sheet
  void _showBottomSheet() {
    Future.delayed(Duration(milliseconds: 100), () {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          isDismissible: false,
          enableDrag: false,
          context: context,
          builder: (ctx) => Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: uic.background,
              ),
              height: 800,
              //color: uic.background,
              child: GridView.builder(
                
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext ctx, index) => Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: uic.primarySwatch,
                    borderRadius: BorderRadius.circular(15),
                    // color: uic.secondary,
                  ),
                  child: ListView(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: uic.selectioncolor,
                        child: Text(
                          'Item $index',
                          style: TextStyle(
                            color: uic.textcolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Adithya Anil',
                      )
                    ],
                  ),
                ),
              ))).whenComplete(() => Navigator.pop(context));
    });
  }

  @override
  void initState() {
    _showBottomSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 100),
            alignment: Alignment.topCenter,
            height: double.infinity,
            width: double.infinity,
            color: uic.yellow,
            child: Image(
              image: AssetImage('assets/textlogoblackpng.png'),
            )));
  }
}
