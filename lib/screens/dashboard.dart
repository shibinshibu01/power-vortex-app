import 'package:flutter/material.dart';
import '../obj/ui.dart';
import '../global.dart';
class DashBoard extends StatefulWidget {
  UIComponents ui;
  DashBoard({super.key, required this.ui});

  @override
  State<DashBoard> createState() => _DashBoardState(ui);
}

class _DashBoardState extends State<DashBoard> {
  UIComponents ui = UIComponents();
  _DashBoardState(this.ui);
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            'Dashboard \n${currentuser!.displayName}',
            style: TextStyle(
              color: ui.textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );;
  }
}

