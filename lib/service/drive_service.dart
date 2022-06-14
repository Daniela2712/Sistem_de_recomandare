import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';

import '../nodeClass.dart';
import 'bestTransit_service.dart';


class Tronson {
  String id;
  String origin;
  String destination;
  String duration;
  String durationA;
  String distance;
  String cost;

  Tronson({
    this.id,
    this.origin,
    this.destination,
    this.duration,
    this.durationA,
    this.distance,
    this.cost
  });

  @override
  String toString() {
    return 'Tronson(id: $id, origin: $origin, destination: $destination, duration: $duration, $distance:distance, cost: $cost)';
  }
}


class TronsonRouteApiProviderWithCar {
  final client = Client();

  TronsonRouteApiProviderWithCar();

  final directionsApiKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';

  double tronsonCostWithCar(String distance) {
    var consum = 6; // 6 litre/100km
    var carburantCost = 7; // 7 lei per litre
    String distanceConverted=distance.replaceAll(
        new RegExp(r'[^0-9]'), '');

    double cost = (((consum / 100) * double.parse(distanceConverted) * carburantCost)/4.94);
    return cost;
  }

  //6l........100km
  //xl........1km
  //x=6*1/100=0.06l

  Future<List<Node>> getRouteDetailToRomanianAirportWithCar(String origin) async {
    List romaniaAirportsMap = [
      {
        "name": "Henri Coanda International Airport",
        "city": "Bucharest",
        "country": "Romania",
        "iataCode": "OTP",
      },
      {
        "name": "Cluj Avram Iancu International Airport",
        "city": "Cluj",
        "country": "Romania",
        "iataCode": "CLJ",
      },
      {
        "name": "Iași International Airport",
        "city": "Iasi",
        "country": "Romania",
        "iataCode": "IAS",
      },
      {
        "name": "Oradea International Airport",
        "city": "Oradea",
        "country": "Romania",
        "iataCode": "OMR",
      },
      // {
      //   "name": "Sibiu International Airport",
      //   "city": "Sibiu",
      //   "country": "Romania",
      //   "iataCode": "SBZ",
      // },
      // {
      //   "name": "Transilvania Targu Mureș Airport",
      //   "city": "Targu Mures",
      //   "country": "Romania",
      //   "iataCode": "TGM",
      // },
      {
        "name": "Timișoara Traian Vuia International Airport",
        "city": "Timisoara",
        "country": "Romania",
        "iataCode": "TSR",
      }
    ];

    List<Node> nodeDetails = [];
    for (int i = 0; i < romaniaAirportsMap.length; i++) {

      final carNodes = await getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
          origin, romaniaAirportsMap[i]["name"]);
      carNodes[0].length=carNodes.length.toString();
      nodeDetails.add(carNodes[0]);
    }
    return nodeDetails;
  }


  Future<List<Node>> getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
      String origin,
      String destination
      ) async {
    var Url = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&key=$directionsApiKey";
    final results = await client.get(Uri.parse(Url));
    final tronson = Tronson();
    List<Node> carNodes = [];
    if (results.statusCode == 200) {
      final result = json.decode(results.body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration'] != null) {
              tronson.duration = d['duration']['value'].toString();
              tronson.durationA = d['duration']['text'].toString();
            }
            if (d['distance'] != null) {
              tronson.distance = d['distance']['text'].toString();
              tronson.cost = tronsonCostWithCar(tronson.distance).toStringAsFixed(2);
              tronson.origin = origin;
              tronson.destination = destination;
            }
          });
        });
        Node n = new Node();
        if(tronson.origin != null)
          n.origin=tronson.origin.toString();
        if(tronson.destination != null)
          n.destination=tronson.destination.toString();
        if(tronson.duration != null) {
          n.duration = tronson.duration.toString();
          n.durationA=tronson.durationA.toString();
        }
        else
          n.duration="0";
        if(tronson.distance != null)
          n.distance=tronson.distance.toString();
        else
          n.distance="0";
        if(tronson.cost != null)
          n.cost=tronson.cost.toString();
        else
          n.cost="0";
        n.efort=(double.parse(tronson.distance.replaceAll(
            new RegExp(r'[^0-9]'), ''))/100).round().toString();
        n.weight=NodeCalc().calcWeight(n).toString();

        carNodes.add(n);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    return carNodes;
  }

}