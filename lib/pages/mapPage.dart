import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticket_hoarder/main.dart' as ma;
import 'package:ticket_hoarder/map/userLocation.dart' as loc;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {}

  @override
  Widget build(BuildContext context) {
    loc.UserLocation currLoc = loc.UserLocation();
    double latitude = currLoc.getLatitude;
    print(latitude);
    return MaterialApp(
      home: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(60.3913, 5.3221),
          zoom: 12,
        ),
        markers: _markers.values.toSet(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
