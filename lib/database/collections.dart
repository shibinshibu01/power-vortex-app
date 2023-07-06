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
void getHomeDetails(index) async {
  String homeID;
  final homeidref = await FirebaseDatabase.instance
      .ref()
      .child("users")
      .child(currentuser!.uid)
      .child("homes");
  homeidref.once().then((DatabaseEvent snapshot) async {
    DataSnapshot values = snapshot.snapshot;
    homeID = values.children.elementAt(index).key.toString();
    print(homeID);
    final homeref =
        await FirebaseDatabase.instance.ref().child("homes").child(homeID);
    homeref.once().then((DatabaseEvent snapshot) async {
      DataSnapshot values = snapshot.snapshot;
      //print(values.value);
      HomeDetails home = HomeDetails(
        hid: homeID,
        name: values.child('name').value.toString(),
        users: [],
        rooms: [],
      );

      home.users.add(userdetails);
      List rooms = values.child('rooms').children.toList();
      print(rooms);
      for (var room in rooms) {
        Room roomdetails = Room(
          //lightimage: 'assets/images/light.png',
          type: RoomType.other,
          rid: room['roomid'],
          name: room['name'],
          boards: [
            Board(
              bid: room['board'],
              devices: [],
            )
          ],
        );
        home.rooms.add(roomdetails);
      }
      userdetails.homes.add(home);
      updateUserHomes();
    });
    // print(values);
  });
  //search for homeId in Homes collection and get the details
}
