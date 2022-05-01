import 'package:flutter/material.dart';
import 'package:ticket_hoarder/models/bus_model.dart';
import 'package:ticket_hoarder/models/transport_interface.dart';
import 'package:ticket_hoarder/models/walk_model.dart';

class TransportModel {
  String mainTransport = "null";
  List<TransportInterface> transportItems = [];

  String? duration;
  int? durationValue;
  String? distance;
  String transportTitle = "Error";

  Icon icon = const Icon(
    Icons.question_answer_outlined,
    color: Colors.grey,
    size: 36,
  );

  TransportModel({this.duration, this.durationValue, this.distance});

  //Color stuff
  Map iconColor = {
    4: const Color.fromARGB(255, 245, 136, 128),
    3: Colors.grey,
    2: Colors.grey
  };
  Map iconIcon = {
    4: Icons.directions_bus_filled,
    3: Icons.directions_bike,
    2: Icons.directions_walk_outlined
  };

  Map tansHierarchy = {"transit": 4, "bicycling": 3, "walking": 2};
  int transportValue = 0;

  //method that assign values to respective datatype vairables
  TransportModel.fromJson(Map<String, dynamic> directionData1) {
    Map<String, dynamic> directionData = directionData1["legs"][0];

    duration = directionData["duration"]["text"];
    durationValue = directionData["duration"]["value"];
    distance = directionData["distance"]["text"];
    if (directionData.length == 11) {
      duration = directionData["arrival_time"]["text"];
    }
  }

  void setMainTransport(transport, transportItem) {
    if (transportValue < tansHierarchy[transport]) {
      transportValue = tansHierarchy[transport];
      mainTransport = transport;
      transportTitle = transportItem.tTitle;
    }
  }

  void setItems(map) {
    for (var item in map["legs"][0]["steps"]) {
      if (item["travel_mode"] == "TRANSIT") {
        TransportInterface transportItem = BusModel.fromJson(item);
        transportItems.add(transportItem);
        setMainTransport("transit", transportItem);
      } else if (item["travel_mode"] == "WALKING") {
        TransportInterface transportItem = WalkModel.fromJson(item);
        transportItems.add(transportItem);
        setMainTransport("walking", transportItem);
      }
    }
    setIcon();
  }

  String printInfo() {
    String output = 'Ankommer destinasjonen: $duration\n'
        'Distanse $distance';
    return output;
  }

  String printTitle() {
    String output = 'Transportation choice: $mainTransport';
    return output;
  }

  void setIcon() {
    icon = Icon(
      iconIcon[transportValue],
      color: iconColor[transportValue],
      size: 36.0,
    );
  }

  Icon getIcon() {
    return icon;
  }
}
