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
  String distance;
  String cost;

  Tronson({
    this.id,
    this.origin,
    this.destination,
    this.duration,
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
    String distanceConverted=distance.replaceAll("km", "").trim();
    double cost = (consum / 100) * double.parse(distanceConverted) * carburantCost;
   // print(cost);
    return cost;
  }

  //6l........100km
  //xl........1km
  //x=6*1/100=0.06l

  Future<List<List<String>>> getRouteDetailToRomanianAirportWithCar(String origin) async {
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
      {
        "name": "Sibiu International Airport",
        "city": "Sibiu",
        "country": "Romania",
        "iataCode": "SBZ",
      },
      {
        "name": "Transilvania Targu Mureș Airport",
        "city": "Targu Mures",
        "country": "Romania",
        "iataCode": "TGM",
      },
      {
        "name": "Timișoara Traian Vuia International Airport",
        "city": "Timisoara",
        "country": "Romania",
        "iataCode": "TSR",
      }
    ];

    List<List<String>> totalDetailsVector = [];

    for (int i = 0; i < romaniaAirportsMap.length; i++) {
      List<String> tronsonToAirport = [];

      final distanceTo = await getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
          origin, romaniaAirportsMap[i]["name"]);
      var intStrDist = distanceTo.distance.replaceAll(
          new RegExp(r'[^0-9,.]'), '');

      tronsonToAirport.add(intStrDist);
      var intStrDur = distanceTo.duration.replaceAll(
          new RegExp(r'[^0-9,.]'), '');

      tronsonToAirport.add(intStrDur);
      tronsonToAirport.add(distanceTo.cost.toString());
      tronsonToAirport.add(distanceTo.origin);
      tronsonToAirport.add(distanceTo.destination);

      //totalDetailsVector.add(tronsonToAirport);
    }


    // print("-----------------------");
    // for (int i = 0; i < totalDetailsVector.length; i++) {
    //   for (int j = 0; j < 5; j++) {
    //     print(totalDetailsVector[i][j]);
    //print(carNodes);
    //   }
    //   print("-----------------------");
    //}

    return totalDetailsVector;
  }


  Future<Tronson> getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
      String origin,
      String destination
      ) async {
    var Url = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&key=$directionsApiKey";
    final results = await client.get(Uri.parse(Url));
    final tronson = Tronson();

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
            }
            if (d['distance'] != null) {
              tronson.distance = d['distance']['text'].toString();
              tronson.cost = tronsonCostWithCar(tronson.distance).toString();
              tronson.origin = origin;
              tronson.destination = destination;
            }
          });
        });
        List<Node> carNodes = [];
        Node n = new Node();
        if(tronson.origin != null)
          n.origin=tronson.origin.toString();
        if(tronson.destination != null)
          n.destination=tronson.destination.toString();
        if(tronson.duration != null)
          n.duration=tronson.duration.toString();
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

        n.weight=NodeCalc().calcWeight(n).toString();
        n.efort=(double.parse(tronson.distance.replaceAll(
            new RegExp(r'[^0-9,.]'), ''))/100).round().toString();
        carNodes.add(n);
        print(carNodes);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    return tronson;
  }


  Future<List<String>> getNearestAirportFromOrigin(String origin) async {
    List<Location> location = await locationFromAddress(origin);

    //getDistanceToRomanianAirport(origin);

    var latitude = location[0].latitude;
    var longitude = location[0].longitude;
    // print(latitude);
    // print(longitude);
    var nearestAirportUrl = "https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance";
    var airportName;
    var iataCode;
    var cityCode;
    var distanceAirFromOr;
    List<String> nearestAirDetails;

    var secResponse = await client.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      body: {
        "grant_type": "client_credentials",
        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
        "client_secret": "rIJW2hknmn7g4o5w",
      },
    );
    //https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance
   // print(secResponse);
    if (secResponse.statusCode == 200) {
      try {
        //print(secResponse.body);
        var security = jsonDecode(secResponse.body);
        //print(security);
        if (security != null) {
          var tokenType = security['token_type'];
         // print(tokenType);
         // print(security['access_token']);
          var token = security['access_token'];
          var bearerToken = '$tokenType ' + '$token';
         // print("token: " + bearerToken);
          var response = await client.get(Uri.parse(
              nearestAirportUrl),
              headers: {
                "Authorization": bearerToken,

              });
          final result = json.decode(response.body);
          //print(result);
          if (result['status'] == 'OK') {
            final components = result['data'] as List<dynamic>;
           // print(components);
            airportName = result['data']['name'];
            iataCode = result['data']['iataCode'];
           // print(components);
            components.forEach((c) {
              cityCode = c['adress']['cityCode'];
              distanceAirFromOr = c['distance']['value'];
            });
            nearestAirDetails.insert(0, airportName);
            nearestAirDetails.insert(1, iataCode);
            nearestAirDetails.insert(2, cityCode);
            nearestAirDetails.insert(3, distanceAirFromOr);
          }
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      } catch (e) {
        print(e.toString());
      }
     // print(nearestAirDetails);
      return nearestAirDetails;
    }
  }
}