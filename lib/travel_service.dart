
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sistem_de_recomandare/model/database_manager.dart';
class TravelData {
  String id;
  String origin;
  String destination;
  String buget;
  String nrPersons;
  String destType;
  String travelMode;


  TravelData({
    this.id,
    this.origin,
    this.destination,
    this.buget,
    this.nrPersons,
    this.destType,
    this.travelMode
  });

  @override
  String toString() {
    return 'TravelData(id: $id, origin: $origin, destination: $destination, buget: $buget, $nrPersons:nrPersons, destType: $destType, $travelMode: travelMode)';
  }
}
final client = Client();

class ProcessTravelData {


  ProcessTravelData(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyBrLgdXNKKw0FpUspuliQWmjDsR6bpvtRo';
  final apiKey =  androidKey;

  Future<Tronson> getTronsonRouteDetailFromOriginAndDestination(String origin,
      String buget, String NumberOfPersons, String destinationType) async {
    //final request =
     //   'https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$apiKey&transit_mode=train';
  //  final response = await client.get(Uri.parse(request));


    List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");



  }
}
