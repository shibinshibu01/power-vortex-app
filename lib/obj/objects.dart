import 'dart:math';

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
  List<Board> boards;
  Room({required this.rid, required this.boards});
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

class Home {
  String hid;
  List<Room> rooms;
  List<User> users;
  Home({required this.hid, required this.rooms, required this.users});
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

class User {
  String uid;
  String name;
  String email;
  String phone;
  DateTime dob;
  List<Home> homes=[];
  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.dob,
      
      });
}
