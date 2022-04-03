import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticket_hoarder/map/direction_model.dart';
import 'package:ticket_hoarder/map/direction_repository.dart';

//import 'package:ticket_hoarder/map/userLocation.dart' as loc;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // GoogleMapController _mapController;
  Marker origin = const Marker(
      markerId: MarkerId("origin"), position: LatLng(60.3913, 5.3221));

  Marker destination = Marker(
      infoWindow: const InfoWindow(title: 'Destination'),
      markerId: const MarkerId("destination"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position:
          const LatLng(60.36852657310426, 5.350100429246856)); // HVL Coords

  static const noPos = LatLng(0.0, 0.0);

  Marker _aPlace = Marker(
    markerId: const MarkerId("_aPlace"),
    infoWindow: const InfoWindow(title: "TODO: add name of Aplace here"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  );
  Marker _bPlace = Marker(
    markerId: const MarkerId("_bPlace"),
    infoWindow: const InfoWindow(title: "TODO: add name of Bplace here"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  //final Map<String, Marker> _markers = {};

  Directions? info;

  Future<void> _onMapCreated(GoogleMapController controller) async {}

  @override
  Widget build(BuildContext context) {
    //loc.UserLocation currLoc = loc.UserLocation();
    //double latitude = currLoc.getLatitude;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Ticket Hoarder Map"),
        actions: [
          TextButton(
              onPressed: () => findDirection(),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('Get Direction'))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(60.3913, 5.3221),
              zoom: 12,
            ),
            //markers: {origin, destination},
            markers: {
              if (_aPlace.position != noPos) _aPlace,
              if (_bPlace.position != noPos) _bPlace
            },
            onLongPress: _addMarker,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            polylines: {
              if (info != null)
                Polyline(
                  polylineId: const PolylineId('overview'),
                  color: Colors.lime,
                  width: 5,
                  points: info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                )
            },
          ),
          if (info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent[600],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${info?.totalDistance}, ${info?.totalDuration}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> findDirection() async {
    // LatLng pos <- potential parameter?

    // Get directions
    if (_aPlace.position != noPos && _bPlace.position != noPos) {
      final directions = await DirectionsRepository().getDirections(
          origin: _aPlace.position, destination: _bPlace.position);
      setState(() => info = directions!);
    }
  }

  void _addMarker(LatLng pos) {
    if (_aPlace.position == noPos ||
        (_aPlace.position != noPos && _bPlace.position != noPos)) {
      setState(() {
        _aPlace = Marker(
            markerId: const MarkerId("_aPlace"),
            infoWindow:
                const InfoWindow(title: "TODO: add name of Aplace here"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos);
        _bPlace = Marker(
          markerId: const MarkerId("_bPlace"),
          infoWindow: const InfoWindow(title: "TODO: add name of Bplace here"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      });
    } else {
      setState(() {
        _bPlace = Marker(
            markerId: const MarkerId("_bPlace"),
            infoWindow:
                const InfoWindow(title: "TODO: add name of Bplace here"),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });
      findDirection();
    }
  }
}
