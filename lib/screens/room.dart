import 'package:flutter/material.dart';
import 'package:powervortex/global.dart';

import '../obj/objects.dart';

class RoomPage extends StatefulWidget {
  final Room room;
  const RoomPage({super.key, required this.room});

  @override
  State<RoomPage> createState() => _RoomPageState(room);
}

class _RoomPageState extends State<RoomPage> {
  Room room;
  _RoomPageState(this.room);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uic.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              room.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            ),
          ],
        ),
      ),);
  }
}