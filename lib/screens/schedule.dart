import 'package:flutter/material.dart';
import '../obj/ui.dart';

class Schedule extends StatefulWidget {
  UIComponents ui;
  Schedule({super.key, required this.ui});

  @override
  State<Schedule> createState() => _ScheduleState(ui);
}

class _ScheduleState extends State<Schedule> {
  UIComponents ui = UIComponents();
  _ScheduleState(this.ui);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            'Schedule',
            style: TextStyle(
              color: ui.textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );
  }
}

