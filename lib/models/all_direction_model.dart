import 'package:ticket_hoarder/models/transport_model.dart';

class AllDirectionModel {
  List<TransportModel> directions = [];

  void setItems(map) {
    for (Map<String, dynamic> transOption in map) {
      for (Map<String, dynamic> directionData in transOption["routes"]) {
        TransportModel direction = TransportModel.fromJson(directionData);
        direction.setItems(directionData);
        directions.add(direction);
      }
    }
  }
}
