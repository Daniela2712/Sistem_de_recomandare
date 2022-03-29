// import 'dart:convert';
// import 'dart:core';
// import 'dart:math';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart';
// import 'package:sistem_de_recomandare/travel_service.dart';
//
//
// class Fly {
//   String id;
//   String origin;
//   String destination;
//   String duration;
//   String departureTime;
//   String departureTerminal;
//   String arrivalTime;
//   String arrivalTerminal;
//   String departureIataCode;
//   String arrivalIataCode;
//   String cost;
//
//   Fly({
//     this.id,
//     this.origin,
//     this.destination,
//     this.duration,
//     this.departureTime,
//     this.departureTerminal,
//     this.arrivalTime,
//     this.arrivalTerminal,
//     this.departureIataCode,
//     this.arrivalIataCode,
//     this.cost
//   });
//
//   @override
//   String toString() {
//     return 'Fly(id: $id, origin: $origin, destination: $destination, duration: $duration, $departureTime:departureTime, departureTerminal: $departureTerminal, $arrivalTime:arrivalTime, $arrivalTerminal:arrivalTerminal, $cost:cost)';
//   }
// }
//
//
// Future<Fly> getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(
//     String origin,
//     String destination,
//     String buget,
//     String numberOfPersons,
//     String departureDate
//     ) async {
//
//   var airUrl = "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=$destination&departureDate=$departureDate&adults=$numberOfPersons&nonStop=false&maxPrice=$buget&max=10";
//
//   var resultsFlights = await client.post(
//     Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
//     body: {
//       "grant_type": "client_credentials",
//       "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
//       "client_secret": "rIJW2hknmn7g4o5w",
//     },
//   );
//   print(resultsFlights);
//   if (resultsFlights.statusCode == 200) {
//     try {
//       print(resultsFlights.body);
//       var security = jsonDecode(resultsFlights.body);
//       final fly = Fly();
//       print(security);
//       if (security != null) {
//         var tokenType = security['token_type'];
//         print(tokenType);
//         print(security['access_token']);
//         var token = security['access_token'];
//         var bearerToken = '$tokenType ' + '$token';
//         print("token: " + bearerToken);
//         var response = await client.get(Uri.parse(airUrl),
//             headers: {
//               "Authorization": bearerToken,
//             });
//         final result = json.decode(response.body);
//         print(result);
//         if (result['status'] == 'OK') {
//           final components = result['data'] as List<dynamic>;
//           print(components);
//
//           List<List<String>> departureTime = [];
//           List<List<String>> departureTerminal = [];
//           List<List<String>>departureIataCode = [];
//           List<List<String>> arrivalTime = [];
//           List<List<String>> arrivalTerminal = [];
//           List<List<String>> arrivalIataCode = [];
//           List<List<String>> totalDuration = [];
//           List<List<String>> segDuration = [];
//
//           components.forEach((d) {
//             final itinerComp = d['itineraries'] as List<dynamic>;
//             final segComp = d['itineraries']['segments'] as List<dynamic>;
//             itinerComp.forEach((it) {
//               for (int i = 0; i < components.length; i++) {
//                 totalDuration[i] = it[i]['duration'];
//                 segComp.forEach((seg) {
//                     for (int j = 0; j < segComp.length; j++) {
//                       final fly = Fly();
//                       departureTime[i][j] = seg[j]['departure']['at'];
//                       departureTerminal[i][j] = seg[j]['departure']['terminal'];
//                       departureIataCode[i][j]= seg[j]['departure']['iataCode'];
//                       arrivalTime[i][j] = seg[j]['arrival']['at'];
//                       arrivalTerminal[i][j] = seg[j]['arrival']['terminal'];
//                       arrivalIataCode[i][j]= seg[j]['arrival']['iataCode'];
//                       segDuration[i][j] = seg[j]['duration'];
//                     }
//                   });
//                 }
//             });
//           });
//         }
//       } else {
//         throw Exception('Failed to fetch suggestion');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return fly;
//   }
