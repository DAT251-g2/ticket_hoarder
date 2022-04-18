import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ticket_hoarder/map/address_search.dart';
import 'package:ticket_hoarder/map/place_service.dart';
import 'package:ticket_hoarder/pages/test_page.dart';
import 'package:ticket_hoarder/pages/map_page.dart';
import 'package:ticket_hoarder/pages/setttings_page.dart';
//import 'package:google_places_flutter/google_places_flutter.dart/';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double latitude = 60.3913;
  double longitude = 5.3221;
  String _streetNumberFra = '';
  String _streetFra = '';
  LatLng _locationFra = const LatLng(0.0, 0.0);
  String _streetNumberTil = '';
  String _streetTil = '';
  String _placeIdTil = '';
  String _placeIdFra = '';
  LatLng _locationTil = const LatLng(0.0, 0.0);
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 12);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            onTap: () async {
              final sessionToken = const Uuid().v4();
              final Suggestion? result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
              );
              if (result != null) {
                _placeIdTil = result.placeId;
                final placeDetails = await PlaceApiProvider(sessionToken)
                    .getPlaceDetailFromId(result.placeId);
                setState(() {
                  _controller.text = result.description;
                  _streetNumberFra = placeDetails.streetNumber;
                  _streetFra = placeDetails.street;
                  _locationFra = placeDetails.location;
                });
              }
            },
            // with some styling
            decoration: InputDecoration(
              icon: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
              ),
              hintText: "Fra",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
          TextField(
            controller: _controller2,
            onTap: () async {
              final sessionToken = const Uuid().v4();
              final Suggestion? result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
              );
              if (result != null) {
                _placeIdTil = result.placeId;
                final placeDetails = await PlaceApiProvider(sessionToken)
                    .getPlaceDetailFromId(result.placeId);
                setState(() {
                  _controller2.text = result.description;
                  _streetNumberTil = placeDetails.streetNumber;
                  _streetTil = placeDetails.street;
                  _locationTil = placeDetails.location;
                });
              }
            },
            // with some styling
            decoration: InputDecoration(
              icon: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: const Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ),
              hintText: "Til",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
          const SizedBox(height: 20.0),
          Text('Street: $_streetFra $_streetNumberFra'),
          Text('Street: $_streetTil $_streetNumberTil'),
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
                if (_streetFra != '' && _streetTil != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(
                              startPos: _placeIdFra,
                              endPos: _placeIdTil,
                              startLocation: _locationFra,
                              endLocation: _locationTil,
                            )),
                  );
                } else {}
              } //else block should notify user of field with no input
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
