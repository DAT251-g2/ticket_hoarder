import 'package:ticket_hoarder/models/transport_interface.dart';

class BusModel implements TransportInterface {
  String mode = "TRANSIT";

  String? busNr;
  String? busName;

  String? depatureTime;
  String? depatureAddress;

  String? arrivalTime;
  String? arrivalAddress;

  //String? stopNameArrival;
  //String? stopNameDepature;

  BusModel({
    this.busNr,
    this.busName,
    this.depatureTime,
    this.depatureAddress,
    this.arrivalTime,
    this.arrivalAddress,
  });

  //method that assign values to respective datatype vairables
  BusModel.fromJson(Map<String, dynamic> routeStepsItem) {
    busNr = routeStepsItem["transit_details"]["line"]["short_name"];
    busName = routeStepsItem["transit_details"]["line"]["name"];

    depatureTime = routeStepsItem["transit_details"]["departure_time"]["text"];
    depatureAddress =
        routeStepsItem["transit_details"]["departure_stop"]["name"];

    arrivalTime = routeStepsItem["transit_details"]["arrival_time"]["text"];
    arrivalAddress = routeStepsItem["transit_details"]["arrival_stop"]["name"];
  }

  @override
  String toString() {
    return '{ $busNr, $busName, $depatureTime, $depatureAddress, $arrivalTime, $arrivalAddress }';
  }

  @override
  String printTitle() {
    String output = 'Bus/Transit: $busNr';
    return output;
  }

  @override
  String printInfo() {
    String output = 'Take bus/transit: $busNr - $busName\n'
        'Depature: $depatureTime at $depatureAddress\n'
        'Arriavel: $arrivalTime at $arrivalAddress';

    return output;
  }
}
