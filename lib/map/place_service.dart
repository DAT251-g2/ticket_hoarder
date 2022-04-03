import 'dart:convert';
//import 'dart:io';

import 'package:http/http.dart';

class Place {
  String streetNumber = '';
  String street;

  Place({
    streetNumber,
    required this.street,
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
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:no&key=$androidKey&sessiontoken=$sessionToken');

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
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$androidKey&sessiontoken=$sessionToken');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place(street: '', streetNumber: '');
        for (var c in components) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
        }
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
