import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powervortex/obj/objects.dart';
import 'database/auth.dart';
import 'obj/ui.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
late User? currentuser;
late UIComponents uic;
late UserDetails userdetails;
int dayindex = 0;
List schedules = [];
late Image image;
late FlutterLocalNotificationsPlugin notifications;
Future<void> showNotification(devicename, roomname, status) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          '123', // Replace with your channel ID
          'Schedule', // Replace with your channel name
          // Replace with your channel description
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          color: uic.yellow);

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await notifications.show(
    0, // Notification ID
    'Schedule', // Notification title
    '$devicename of $roomname has turned $status', // Notification body
    platformChannelSpecifics,
    payload: 'Custom Payload',
  );
}
