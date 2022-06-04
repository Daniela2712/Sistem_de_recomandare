import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:sistem_de_recomandare/travel_service.dart';

import '../nodeClass.dart';


class Fly {
  String id;
  String origin;
  String destination;
  String duration;
  String segmentDuration;
  String departureTime;
  String departureTerminal;
  String arrivalTime;
  String arrivalTerminal;
  String departureIataCode;
  String arrivalIataCode;
  String cost;

  Fly({
    this.id,
    this.origin,
    this.destination,
    this.duration,
    this.segmentDuration,
    this.departureTime,
    this.departureTerminal,
    this.arrivalTime,
    this.arrivalTerminal,
    this.departureIataCode,
    this.arrivalIataCode,
    this.cost,
  });

  @override
  String toString() {
    return 'Fly(id: $id, origin: $origin, destination: $destination, duration: $duration,segmentDuration:$segmentDuration, departureTime:$departureTime, departureTerminal: $departureTerminal, arrivalTime:$arrivalTime, arrivalTerminal:$arrivalTerminal, departureIataCode:$departureIataCode, arrivalIataCode:$arrivalIataCode, cost:$cost)';
  }
}
class TronsonRouteApiProviderForFly {

  Future<List<List<Node>>> getRouteDetailFromAirToDestinationWithAir(
      String destination) async {
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

    List<List<List<String>>> totalDetailsVector = [];
    List<List<Node>> tronsonToDest = [];
    List<Node> nodeDetails = [];
    for (int i = 0; i < romaniaAirportsMap?.length; i++) {
      tronsonToDest = [];
      final flyNodes = await getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(
          romaniaAirportsMap[i]["iataCode"], destination);
      for (int j = 0; j < flyNodes.length; j++) {
          nodeDetails.add(flyNodes[j]);
          }
      tronsonToDest.add(nodeDetails);
    }
    return tronsonToDest;
  }


  Future<List<Node>> getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(
      String origin,
      String destination,) async {
    var airUrl = "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=$destination&departureDate=2022-11-10&adults=3&nonStop=false&max=5";

    var resultsFlights = await client.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      body: {
        "grant_type": "client_credentials",
        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
        "client_secret": "rIJW2hknmn7g4o5w",
      },
    );
    List<List<List<Fly>>> dataList = [];
    List<List<Fly>> itinerariesList = [];
    List<Fly> stepList = [];
    List<Node> flyNodes = [];


    if (resultsFlights.statusCode == 200) {

      try {
        var security = jsonDecode(resultsFlights.body);
        if (security != null) {
          var tokenType = security['token_type'];
          var token = security['access_token'];
          var bearerToken = '$tokenType ' + '$token';
          var response = await client.get(Uri.parse(airUrl),
              headers: {
                "Authorization": bearerToken,
              });
          final result = json.decode(response.body);
          final components = result['data'] as List<dynamic>;
          components.forEach((d) {
            final itinerComp = d['itineraries'] as List<dynamic>;
            itinerComp.forEach((it) {

              var fly = Fly();
              Node n = new Node();
              fly.duration = it['duration']?.toString();
              fly.origin=origin;
              fly.destination=destination;
              fly.cost=d['price']['total']?.toString();

              n.origin=fly.origin.toString();
              n.destination=fly.destination?.toString();
              n.duration=fly.duration?.toString();
              n.cost=fly.cost?.toString();
              n.distance="0.0";

              final segComp = it['segments'] as List<dynamic>;
              segComp.forEach((seg) {
                var step = Fly();
                if (seg['departure'] != null) {
                  step.departureIataCode = seg['departure']['iataCode']?.toString();
                  step.departureTime = seg['departure']['at']?.toString();
                  step.departureTerminal = seg['departure']['terminal']?.toString();
                  step.origin=step.departureIataCode;
                }
                if (seg['arrival'] != null) {
                  step.arrivalIataCode = seg['arrival']['iataCode']?.toString();
                  step.arrivalTime = seg['arrival']['at']?.toString();
                  step.arrivalTerminal = seg['arrival']['terminal']?.toString();
                  step.destination=step.arrivalIataCode;
                }
                if (seg['duration'] != null) {
                  step.segmentDuration = seg['duration']?.toString();
                }
                stepList.add(step);

                // Node n = new Node();
                //
                // n.origin=step.departureIataCode.toString();
                // n.destination=step.arrivalIataCode.toString();
                // n.duration=step.segmentDuration.toString();
                // n.departure_time=step.departureTime.toString();
                // n.arrival_time=step.arrivalTime.toString();
                // n.departure_location=step.departureIataCode.toString();
                // n.arrival_location=step.arrivalIataCode.toString();
                // n.departureTerminal=step.departureTerminal.toString();
                // n.arrivalTerminal=step.arrivalTerminal.toString();
                //
                // flyNodes.add(n);

              });

              stepList.add(fly);
              itinerariesList.add(stepList);
             n.efort=segComp?.length?.toString();
             n.weight=NodeCalc().calcFlyWeight(n)?.toString();
             flyNodes.add(n);
            });
            dataList.add(itinerariesList);
          });
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      } catch (e) {
        print(e.toString());
      }
      return flyNodes;
    }
  }
}