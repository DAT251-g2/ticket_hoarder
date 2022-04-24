import 'package:ticket_hoarder/models/transport_interface.dart';

class WalkModel implements TransportInterface {
  String mode = "WALKING";

  String? title;

  String? startAddress;
  String? endAddress;

  String? length;
  String? duration;

  //String? stopNameArrival;
  //String? stopNameDepature;

  WalkModel({
    this.title,
    this.startAddress,
    this.endAddress,
    this.length,
    this.duration,
  });

  //method that assign values to respective datatype vairables
  WalkModel.fromJson(Map<String, dynamic> routeStepsItem) {
    title = routeStepsItem["html_instructions"];

    //startAddress = routeStepsItem["steps"];
    //endAddress = routeStepsItem["steps"];

    length = routeStepsItem["distance"]["text"];
    duration = routeStepsItem["duration"]["text"];
  }

  @override
  String toString() {
    return '{ $title, $startAddress, $endAddress, $length, $duration }';
  }

  @override
  String printTitle() {
    String output = '$title';
    return output;
  }

  @override
  String printInfo() {
    String output = 'Length: $length\n'
        'Time:  $duration';

    return output;
  }
}
