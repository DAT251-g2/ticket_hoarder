import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:ticket_hoarder/map/userLocation.dart' as loc;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  // GoogleMapController _mapController;
  Marker origin = const Marker(
      markerId: MarkerId("origin"), position: LatLng(60.3913, 5.3221));
  Marker destination = Marker(
      infoWindow: const InfoWindow(title: 'Destination'),
      markerId: const MarkerId("destination"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position:
          const LatLng(60.36852657310426, 5.350100429246856)); // HVL Coords
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {}

  @override
  Widget build(BuildContext context) {
    //loc.UserLocation currLoc = loc.UserLocation();
    //double latitude = currLoc.getLatitude;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Ticket Hoarder Map"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(60.3913, 5.3221),
          zoom: 12,
        ),
        markers: {origin, destination},
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
