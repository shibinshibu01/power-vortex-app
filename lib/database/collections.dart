import 'package:firebase_database/firebase_database.dart';
import 'package:powervortex/global.dart';
import 'package:powervortex/obj/objects.dart';
import 'package:powervortex/screens/home.dart';
import '../obj/objects.dart';

Future updateUserHomes() async {
  final homeref = await FirebaseDatabase.instance
      .ref()
      .child("users")
      .child(currentuser!.uid)
      .child("homes");
  for (HomeDetails home in userdetails.homes) {
    homeref.child(home.hid).set(home.name);
    List uids = [];
    List rooms = [];
    for (UserDetails user in home.users) {
      uids.add(user.uid);
    }
    for (Room room in home.rooms) {
      rooms.add({
        'name': room.name,
        'board': room.boards.first.bid,
        'roomid': room.rid,
      });
    }

    print(rooms);
    print(uids);
    final dbRef = await FirebaseDatabase.instance.ref();
    await dbRef.child('homes').child(home.hid).child("users").set(uids);
    await dbRef.child('homes').child(home.hid).child("rooms").set(rooms);
  }
}

//fn to get the home details of the user
Future getHomeDetails(index) async {
  String homeID;
  final homeidref = await FirebaseDatabase.instance
      .ref()
      .child("users")
      .child(currentuser!.uid)
      .child("homes");
  homeidref.once().then((DatabaseEvent snapshot) async {
    DataSnapshot values1 = snapshot.snapshot;
    homeID = values1.children.elementAt(index).key.toString();
    if (!userdetails.homes.any((element) {
      print('elemetn : ${element.hid} : $homeID');
      if (element.hid == homeID) {
        print('yes');
        return true;
      } else
        return false;
    })) {
      //print(homeID);
      final homeref =
          await FirebaseDatabase.instance.ref().child("homes").child(homeID);
      homeref.once().then((DatabaseEvent snapshot) async {
        DataSnapshot values = snapshot.snapshot;
        //print(values1.children.elementAt(index).value.toString());
        HomeDetails home = HomeDetails(
          hid: homeID,
          name: values1.children.elementAt(index).value.toString(),
          users: [],
          rooms: [],
        );

        home.users.add(userdetails);
        // print(values.child('rooms'));
        List rooms = List.from(values.child('rooms').value as Iterable);
        print(rooms);
        for (var room in rooms) {
          Room roomdetails = Room(
            //lightimage: 'assets/images/light.png',
            type: RoomType.other,
            rid: room['roomid'].toString(),
            name: room['name'].toString(),
            boards: [
              Board(
                bid: room['board'].toString(),
                devices: [],
              )
            ],
          );

          home.rooms.add(roomdetails);
        }
        userdetails.homes.add(home);
        //updateUserHomes();
// print(userdetails.homes[index].rooms);
        final dbRef = await FirebaseDatabase.instance.ref();

        for (Room room in userdetails.homes[index].rooms) {
          await dbRef.child('boards').once().then((value) async {
            if (value.snapshot.hasChild(room.boards.first.bid)) {
              //print(room.boards.first.bid);
              await dbRef
                  .child('boards')
                  .child(room.boards.first.bid)
                  .once()
                  .then((value) {
                DataSnapshot values = value.snapshot;
                List _devices = [];
                for (int i = 1; i <= 5; i++) {
                  if (values.hasChild(i.toString())) {
                    // print(values.child('$i').value);
                    _devices.add(values.child('$i').value);
                    var d = _devices[i - 1];
                    print(d);
                    // print(d);

                    Device devicedetails = Device(
                      index: i,
                      bid: room.boards.first.bid,
                      consumption: double.parse(d['consumption'].toString()),
                      did: d['did'].toString(),
                      name: d['name'].toString(),
                      type: getDeviceType(d['type']),
                      status: d['status'],
                    );
                    print('adding');
                    room.boards.first.devices.add(devicedetails);
                    if (devicedetails.status)
                      userdetails.homes[index].activeDevices.add(devicedetails);
                  }
                }
              });
            }
          });
        }
      });
    } else
      print('exist');
    // print(values);
  });

  //search for homeId in Homes collection and get the details
}

//fn to set device details inside the board
Future addDevice(Board board, index, Device device) async {
  final dbRef = await FirebaseDatabase.instance.ref();
  List devices = [];
  board.devices.forEach((element) async {
    dbRef.child('boards').child(board.bid).child(index).set({
      'name': element.name,
      'type': element.type.toString(),
      'did': element.did,
      'consumption': element.consumption,
      'status': element.status,
    });
  });
}

Future changeStatus(Device device) async {
  final dbRef = await FirebaseDatabase.instance.ref();
  dbRef
      .child('boards')
      .child(device.bid)
      .child(device.index.toString())
      .child('status')
      .set(device.status);
}
