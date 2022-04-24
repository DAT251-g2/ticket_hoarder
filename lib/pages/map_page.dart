import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticket_hoarder/map/direction_model.dart';
import 'package:ticket_hoarder/map/direction_repository.dart';
import 'package:ticket_hoarder/pages/route_page.dart';

//import 'package:ticket_hoarder/map/userLocation.dart' as loc;

class MapPage extends StatefulWidget {
  final String startPos;
  final String endPos;
  final LatLng endLocation;
  final LatLng startLocation;

  const MapPage(
      {Key? key,
      required this.startPos,
      required this.endPos,
      required this.endLocation,
      required this.startLocation})
      : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    _startPos = widget.startPos;
    _endPos = widget.endPos;
    _startLocation = widget.startLocation;
    _endLocation = widget.endLocation;
    super.initState();
  }

  String _startPos = '';
  String _endPos = '';
  LatLng _startLocation = const LatLng(0.0, 0.0);
  LatLng _endLocation = const LatLng(0.0, 0.0);

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

  Marker get _aPlace => Marker(
      markerId: const MarkerId("_aPlace"),
      infoWindow: InfoWindow(title: _startPos),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: _startLocation);
  Marker get _bPlace => Marker(
      markerId: const MarkerId("_aPlace"),
      infoWindow: InfoWindow(title: _endPos),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: _endLocation);

  //final Map<String, Marker> _markers = {};

  Directions? info;
  late Map<String, dynamic> data;

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
              child: const Text('Get Direction')),
          TextButton(
              onPressed: () => handleOnpress(),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('See direction information')),
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
            markers: {_aPlace, _bPlace},
            myLocationEnabled: true,
            myLocationButtonEnabled: true,

            polylines: {
              if (info != null)
                Polyline(
                  polylineId: const PolylineId('overview'),
                  color: const Color.fromARGB(255, 57, 95, 220),
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

  Future<void> getDirectionData() async {
    // LatLng pos <- potential parameter?

    // Get directions
    if (_aPlace.position != noPos && _bPlace.position != noPos) {
      final directionData = await DirectionsRepository()
          .getData(origin: _aPlace.position, destination: _bPlace.position);
      setState(() => data = directionData!);
    }
  }

  Future<void> handleOnpress() async {
    await getDirectionData();
    //inspect(data);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RoutePage(map: data)));
  }
}
