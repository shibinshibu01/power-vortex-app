import 'package:flutter/material.dart';

Widget home(ui)=> Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            'Home',
            style: TextStyle(
              color: ui.textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );