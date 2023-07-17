import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powervortex/obj/objects.dart';
import 'database/auth.dart';
import 'obj/ui.dart';

late User? currentuser;
late UIComponents uic;
late UserDetails userdetails;
int dayindex = 0;
List schedules = [];