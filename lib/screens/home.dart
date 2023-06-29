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
    }
  }
  String user = 'User';
  List<Device> devices = [];

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
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: devices.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  width: 175,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: ui.primarySwatch,
                    borderRadius: BorderRadius.circular(20),
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
                            color: devices[index].status ? ui.switchon : ui.switchoff,
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
                SizedBox(width: 10),
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
