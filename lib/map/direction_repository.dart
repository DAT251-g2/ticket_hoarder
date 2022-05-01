import 'dart:developer';

import 'package:dio/dio.dart'; // couldn't figure out http

//import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticket_hoarder/.env.dart';
import 'package:ticket_hoarder/map/direction_model.dart';

class DirectionsRepository {
  static const String baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  static const String walking = 'walking';

/*  
  
  LatLng _origin = LatLng(60.3913, 5.3221);
  LatLng _destination = LatLng(60.36852657310426, 5.350100429246856);
*/

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'mode': "transit",
        'key': googleAPIKey,
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    //print("Did not get any helpful response from google");
    return null;
  }

  Future<Map<String, dynamic>?> getTransitData({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'alternatives': 'true',
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'mode': "transit",
        'key': googleAPIKey,
      },
    );

    if (response.statusCode == 200) {
      return response.data;
    }
    //print("Did not get any helpful response from google");
    return null;
  }

  Future<Map<String, dynamic>?> getWalkingData({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'mode': "walking",
        'key': googleAPIKey,
      },
    );

    if (response.statusCode == 200) {
      return response.data;
    }
    //print("Did not get any helpful response from google");
    return null;
  }

  Future<Map<String, dynamic>?> getBicyclingData({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'mode': "bicycling",
        'key': googleAPIKey,
      },
    );

    if (response.statusCode == 200) {
      inspect(response.data);
      return response.data;
    }
    //print("Did not get any helpful response from google");
    return null;
  }
}
