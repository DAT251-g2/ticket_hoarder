import 'dart:convert';
//import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class Place {
  String streetNumber = '';
  String street;
  LatLng location;

  Place({
    streetNumber,
    required this.street,
    required this.location,
  });
}

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();
  final dynamic sessionToken;
  PlaceApiProvider(this.sessionToken);

  static const String androidKey = 'AIzaSyBccZx0jfVDXu0zVGRdHC9lq_w6Pp5Twmo';
  //static final String iosKey = 'YOUR_API_KEY_HERE';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&point:60.3913, 5.3221&types=address&language=$lang&components=country:no&key=$androidKey&sessiontoken=$sessionToken');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component,geometry&key=$androidKey&sessiontoken=$sessionToken');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        final locComp = result['result']['geometry'] as dynamic;

        final place = Place(
            street: '', streetNumber: '', location: const LatLng(0.0, 0.0));
        var loc = locComp['location'];
        if (loc != null) {
          double lat = loc['lat'];
          double lng = loc['lng'];
          place.location = LatLng(lat, lng);
        }

        for (var c in components) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
        }
        //print(place.location);
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
