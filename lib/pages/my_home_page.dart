import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ticket_hoarder/pages/test_page.dart';
import 'package:ticket_hoarder/pages/map_page.dart';
import 'package:ticket_hoarder/pages/setttings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double latitude = 60.3913;
  double longitude = 5.3221;

  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text(
            '${time!.hour.toString()}:${time!.minute.toString()}',
            style: const TextStyle(fontSize: 60),
          ),
          IconButton(
            alignment: Alignment.bottomCenter,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          IconButton(
            alignment: Alignment.bottomCenter,
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapPage()),
              );
            },
          ),
          IconButton(
              onPressed: getMyLocationData,
              icon: const Icon(Icons.panorama_horizontal)),
          IconButton(
            alignment: Alignment.bottomCenter,
            icon: const Icon(Icons.do_disturb_alt_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TestPage()),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.access_time_outlined),
          onPressed: () async {
            TimeOfDay? newTime = await showTimePicker(
              context: context,
              initialTime: time!,
            );
            if (newTime != null) {
              setState(() {
                time = newTime;
              });
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  double get getLatitude {
    return latitude;
  }

  void getMyLocationData() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
  }
}
