import 'package:flutter/material.dart';
import '../obj/ui.dart';
import '../obj/objects.dart';

class Home extends StatefulWidget {
  UIComponents ui;
  Home({super.key, required this.ui});

  @override
  State<Home> createState() => _HomeState(ui);
}

class _HomeState extends State<Home> {
  UIComponents ui;
  _HomeState(this.ui) {
    for (int i = 1; i <= 10; i++) {
      devices.add(Device(
          did: generateID(6),
          name: 'Device $i',
          type: DeviceType.values[i % 6],
          status: true,
          consumption: 100));
      rooms.add(
          Room(rid: generateID(6), boards: [], type: RoomType.values[i % 3] ,lightimage: lightimages[i%2],darkimage: darkimages[i%2]));
    }
  }
  String user = 'User';
  List<Device> devices = [];
  List<Room> rooms = [];
  List<AssetImage> lightimages = [AssetImage('assets/room1.png'),AssetImage('assets/room2.png')];
  List<AssetImage> darkimages = [AssetImage('assets/room1_dark.png'),AssetImage('assets/room2_dark.png')];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hello $user',
              style: TextStyle(
                color: ui.textcolor,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Active Devices',
              style: TextStyle(
                color: ui.textcolor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,bottom: 20,top: 10),
                      child: Container(
                        width: 175,
                        height: 200,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: ui.primarySwatch,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              devices[index].name,
                              style: TextStyle(
                                color: ui.textcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                alignment: Alignment.centerLeft,
                                icon: Icon(
                                  Icons.power_settings_new,
                                  size: 50,
                                  color: devices[index].status
                                      ? ui.switchon
                                      : ui.switchoff,
                                ),
                                onPressed: () {
                                  devices[index].status = !devices[index].status;
                                  setState(() {});
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      if (!devices[index].status) {
                                        devices.removeAt(index);
                                      }
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'My Home',
              style: TextStyle(
                color: ui.textcolor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: rooms.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ui.primarySwatch,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      //color: ui.primarySwatch,
                      height: 200,
                      width: MediaQuery.of(context).size.width - 30,
                      //padding: EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.topLeft,
                                height: 140,
                                child: Text(
                                  rooms[index].type.toString().split('.')[1],
                                  style: TextStyle(
                                    color: ui.textcolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ui.textcolor,
                                  
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                height: 60,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: ui.primarySwatch,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'Open',
                                      style: TextStyle(
                                        color: ui.textcolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 200,
                              width: 250,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: !ui.isDark
                                      ? rooms[index].lightimage
                                      : rooms[index].darkimage,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
