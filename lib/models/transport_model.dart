import 'package:ticket_hoarder/models/bus_model.dart';
import 'package:ticket_hoarder/models/transport_interface.dart';
import 'package:ticket_hoarder/models/walk_model.dart';

class TransportModel {
  List<TransportInterface> transportItems = [];

  void setItems(map) {
    for (var item in map["legs"][0]["steps"]) {
      if (item["travel_mode"] == "TRANSIT") {
        TransportInterface transportItem = BusModel.fromJson(item);
        transportItems.add(transportItem);
      } else if (item["travel_mode"] == "WALKING") {
        TransportInterface transportItem = WalkModel.fromJson(item);
        transportItems.add(transportItem);
      }
    }
  }
}
