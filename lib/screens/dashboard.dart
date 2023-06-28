import 'package:flutter/material.dart';
Widget dashboard(ui)=> Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            'Dashboard',
            style: TextStyle(
              color: ui.textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );