//import 'package:flutter/foundation.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart'; //A flutter plugin that decodes encoded google polyline string into list of geo-coordinates suitable for showing route/polyline on maps
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ticket_hoarder/models/transport_model.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  static Directions? fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if ((map['routes'] as List).isEmpty) {
      /*
      print(
          "WARNING: Route not available?"); 
          */
      return null;
    }

    //inspect(map);

    //File file = File("json_test.json");
    //file.writeAsString(s);

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    TransportModel testTrans = TransportModel();

    testTrans.setItems(data);

    // Bounds
    final ne = data['bounds']['northeast'];
    final sw = data['bounds']['southwest'];

    final bounds = LatLngBounds(
      northeast: LatLng(ne['lat'], ne['lng']),
      southwest: LatLng(sw['lat'], sw['lng']),
    );

    // Distance and Duration
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
        bounds: bounds,
        polylinePoints: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration);
  }
}
