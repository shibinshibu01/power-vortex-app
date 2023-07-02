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
    homeref.child(home.hid).set(
       home.name
    );
    List uids = [];
    List rooms = [];
    for (UserDetails user in home.users) {
      uids.add(user.uid);
      
    }
    for (Room room in home.rooms) {
      uids.add(room.rid);
      
    }
    final dbRef = await FirebaseDatabase.instance.ref();
    await homeref.child(home.hid).child("users").set(uids);
    await homeref.child(home.hid).child("rooms").set(rooms);
  }
}
