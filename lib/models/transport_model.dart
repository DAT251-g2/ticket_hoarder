import 'dart:developer';

import 'package:ticket_hoarder/models/bus_model.dart';
import 'package:ticket_hoarder/models/transport_interface.dart';
import 'package:ticket_hoarder/models/walk_model.dart';

class TransportModel {
  String mainTransport = "null";
  List<TransportInterface> transportItems = [];

  String? duration;
  int? durationValue;
  String? distance;

  TransportModel({
    this.duration,
    this.durationValue,
    this.distance,
  });

  Map tansHierarchy = {"transit": 4, "bicycling": 3, "walking": 2};
  int transportValue = 0;

  //method that assign values to respective datatype vairables
  TransportModel.fromJson(Map<String, dynamic> directionData1) {
    Map<String, dynamic> directionData = directionData1["legs"][0];

    duration = directionData["duration"]["text"];
    durationValue = directionData["duration"]["value"];
    distance = directionData["distance"]["text"];
  }

  void setMainTransport(transport) {
    print("############################################");
    print("transport $transport");
    print("transport value ${tansHierarchy[transport]}");

    if (transportValue < tansHierarchy[transport]) {
      transportValue = tansHierarchy[transport];
      mainTransport = transport;
    }
  }

  void setItems(map) {
    for (var item in map["legs"][0]["steps"]) {
      if (item["travel_mode"] == "TRANSIT") {
        TransportInterface transportItem = BusModel.fromJson(item);
        transportItems.add(transportItem);
        setMainTransport("transit");
      } else if (item["travel_mode"] == "WALKING") {
        TransportInterface transportItem = WalkModel.fromJson(item);
        transportItems.add(transportItem);
        setMainTransport("walking");
      }
    }
  }

  String printInfo() {
    String output = 'Estimated time: $duration\n'
        'Estimated $distance';
    return output;
  }

  String printTitle() {
    String output = 'Transportation choice: $mainTransport';
    return output;
  }
}
