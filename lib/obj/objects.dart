import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String generateID(int length) {
  final random = Random();
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  String randomString = '';
  for (int i = 0; i < length; i++) {
    randomString += chars[random.nextInt(chars.length)];
  }

  return randomString;
}

enum DeviceType { fan, light, tv, ac, fridge, washingMachine, other }
enum RoomType{bedroom, livingroom, kitchen, bathroom, other}

class Device {
  String did;
  String name;
  DeviceType type;
  bool status;
  double consumption;
  Device(
      {required this.did,
      required this.name,
      required this.type,
      required this.status,
      required this.consumption});
  double getConsumption() {
    return consumption;
  }
}

class Board {
  String bid;
  List<Device> devices;
  Board({required this.bid, required this.devices});
  void addDevice(Device device) {
    devices.add(device);
  }
}

class Room {
  String rid;
  AssetImage lightimage;
  AssetImage darkimage;
  List<Board> boards;
  RoomType type;
  Room({required this.rid, required this.boards, required this.type,required this.lightimage,required this.darkimage});
  double getRoomConsumption() {
    double consumption = 0;
    for (var board in boards) {
      for (var device in board.devices) {
        consumption += device.getConsumption();
      }
    }
    return consumption;
  }

  void addBoard(Board board) {
    boards.add(board);
  }
}

class HomeDetails {
  String hid;
  List<Room> rooms;
  List<User> users;
  HomeDetails({required this.hid, required this.rooms, required this.users});
  double getTotalConsumption() {
    double consumption = 0;
    for (var room in rooms) {
      consumption += room.getRoomConsumption();
    }
    return consumption;
  }

  void addRoom(Room room) {
    rooms.add(room);
  }

  void addUser(User user) {
    users.add(user);
  }
}

class UserDetails {
  String uid;
  String name;
  String email;
  String phone;
  DateTime dob;
  List<HomeDetails> homes = [];
  UserDetails({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
  });

  void addHome(HomeDetails home) {
    homes.add(home);
  }

  //implement a sign in method here using firebase auth email and password
  void signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User registration successful
    } catch (e) {
      // Handle registration error
    }
  }
}
