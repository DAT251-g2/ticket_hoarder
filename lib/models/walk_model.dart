import 'package:ticket_hoarder/models/transport_interface.dart';

class WalkModel implements TransportInterface {
  String mode = "WALKING";

  String? title;

  String? startAddress;
  String? endAddress;

  String? length;
  String? duration;
  String tTitle = "Error";

  //String? stopNameArrival;
  //String? stopNameDepature;

  List<String> remove = [
    "<b>",
    "</b>",
    "<",
    ">",
    "/>",
    "div",
    '"style=font-size:0.9em"',
    "/",
    "wbr",
    "style",
    "=",
    '"',
    "font-size:"
        "0.9em"
  ];

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
    setTTitle();
  }

  @override
  String toString() {
    return '{ $title, $startAddress, $endAddress, $length, $duration }';
  }

  @override
  String printTitle() {
    String output = '$title';
    for (final item in remove) {
      output = output.replaceAll(item, "");
    }
    return output;
  }

  void setTTitle() {
    tTitle = 'Gå til destinasjonen';
  }

  @override
  String printInfo() {
    String output = 'Length: $length\n'
        'Time:  $duration';

    return output;
  }
}
