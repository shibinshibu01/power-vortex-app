import 'package:flutter/material.dart';

Widget schedule(ui)=> Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            'Shecdule',
            style: TextStyle(
              color: ui.textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );