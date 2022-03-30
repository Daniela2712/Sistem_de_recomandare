import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';

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


class TronsonRouteApiProvider {
  final client = Client();

  TronsonRouteApiProvider();

  final directionsApiKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';

  double tronsonCostWithCar(String distance) {
    var consum = 6; // 6 litre/100km
    var carburantCost = 7; // 7 lei per litre
    var cost = (consum / 100) * int.parse(distance) * carburantCost;
    return cost;
  }

  //6l........100km
  //xl........1km
  //x=6*1/100=0.06l

  Future<BestTransit> bestTransitMode(String origin, String destination) async {
    // double pBuget=double.parse(buget)*0.3;  //30% from total buget
    List<double> distanceVector = [];
    List<double> durationVector = [];
    List<double> costVector = [];
    List<String> vehicles = ["Car","Train", "Airplane"];
    List<double> sumVehicle = [];
    List<double> finalSum = [];
    int index;

    // print(romaniaAirportsMap.length);
    try {
      final CarDetails = await getDistanceToAirport(
          origin, destination);
      String distanceWithCar = CarDetails.distance.replaceAll("km", "").trim();
      String durationWithCar = CarDetails.duration;

      //var costWithCar = CarDetails.cost;
      print(distanceWithCar);
      print(durationWithCar);
      if (distanceWithCar != null && durationWithCar != null
          ) {
        print("i m hereee");
        distanceVector.add(double.parse(distanceWithCar));
        print(distanceVector);
        durationVector.add(double.parse(durationWithCar));
        print(durationVector[0]*0.5);
       // costVector.add(double.parse(costWithCar));
      }
      // final TrainDetails = await getDistanceToAirport(
      //     origin, destination);
      // var distanceWithTrain = TrainDetails.distance;
      // var durationWithTrain = TrainDetails.duration;
      // //var costWithTrain = TrainDetails.cost;
      // if (distanceWithCar != null && durationWithCar != null
      //    ) {
      //   distanceVector.add(double.parse(distanceWithTrain));
      //   durationVector.add(durationWithTrain);
      //  // costVector.add(double.parse(costWithTrain));
      // }
      // final FlyDetails = await getDistanceToAirport(
      //     origin, destination);
      // var distanceWithAir = FlyDetails.distance;
      // var durationWithAir = FlyDetails.duration;
      // var costWithAir = FlyDetails.cost;
      // if (distanceWithCar != null && durationWithCar != null ) {
      //   distanceVector.add(double.parse(distanceWithAir));
      //   durationVector.add(durationWithAir);
      //   costVector.add(double.parse(costWithAir));
      // }
      for (int i = 0; i < 1; i++) {
        print(i);
        double sum=((distanceVector[i]*0.5)+(durationVector[i]*0.35));
        sumVehicle.add(sum);
        print(sumVehicle);
            //+ double.parse(durationVector[i].replaceAll(new RegExp(r'[^0-9,.]'), '')) * 0.35;
        //finalSum[i]=sumVehicle[i];
        double minimum = sumVehicle.reduce(min);
        if (sumVehicle[i] == minimum) {
          index = i;
        }
      }

      BestTransit bestTransit;
      bestTransit.vehicle = vehicles[index];
      bestTransit.cost = costVector[index] as String;
      bestTransit.duration = durationVector[index] as String;
      bestTransit.distance = distanceVector[index] as String;
      print(bestTransit.vehicle);
      print(bestTransit);
      return bestTransit;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getDistanceToRomanianAirport(String origin) async {
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
      int index = 0;
      List<double> distanceVector = [];
      // print(romaniaAirportsMap.length);
      for (int i = 0; i < romaniaAirportsMap.length; i++) {
        print(romaniaAirportsMap[i]["name"]);
          final distanceTo = await getDistanceToAirport(origin, romaniaAirportsMap[i]["name"]);
          var intStr = distanceTo.distance.replaceAll(new RegExp(r'[^0-9,.]'), '');
          distanceVector.add(double.parse(intStr));

          double dist=distanceVector[i];
          double minimum=distanceVector.reduce(min);
          print(dist);
          if(dist==minimum)
            index=i;

          print(index);
        }

        print(romaniaAirportsMap[index]["iataCode"]);

        return romaniaAirportsMap[index]["iataCode"];

  }


  Future<Tronson> getDistanceToAirport(
      String origin,
      String destination
      ) async {
    var Url = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&key=$directionsApiKey";
    final results = await client.get(Uri.parse(Url));
    print(results.body);
    final tronson = Tronson();

    if (results.statusCode == 200) {
      final result = json.decode(results.body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        //print(components);
        // build result
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration'] != null) {
              tronson.duration = d['duration']['value'].toString();
            }
            if (d['distance'] != null) {
              print(d['distance']['text']);
              tronson.distance = d['distance']['text'].toString();
            }
          });
        });
       // tronson.cost = tronsonCostWithCar(tronson.distance) as String;
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    return tronson;
  }


  Future<List<String>> getNearestAirportFromOrigin(String origin) async {
    List<Location> location = await locationFromAddress(origin);

    getDistanceToRomanianAirport(origin);

    var latitude = location[0].latitude;
    var longitude = location[0].longitude;
    print(latitude);
    print(longitude);
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
    print(secResponse);
    if (secResponse.statusCode == 200) {
      try {
        print(secResponse.body);
        var security = jsonDecode(secResponse.body);
        print(security);
        if (security != null) {
          var tokenType = security['token_type'];
          print(tokenType);
          print(security['access_token']);
          var token = security['access_token'];
          var bearerToken = '$tokenType ' + '$token';
          print("token: " + bearerToken);
          var response = await client.get(Uri.parse(
              'https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance'),
              headers: {
                "Authorization": bearerToken,

              });
          final result = json.decode(response.body);
          print(result);
          if (result['status'] == 'OK') {
            final components = result['data'] as List<dynamic>;
            airportName = result['data']['name'];
            iataCode = result['data']['iataCode'];
            print(components);
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
      print(nearestAirDetails);
      return nearestAirDetails;
    }
  }


    Future<Tronson> getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
        String origin,
        String destination,
        ) async {
      var driveUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=drive&key=$directionsApiKey";
      final response = await client.get(Uri.parse(driveUrl));
      print(response.body);
      final tronson = Tronson();
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
       // print(result);
        if (result['status'] == 'OK') {
          final components =
          result['routes'] as List<dynamic>;
          //print(components);
          components.forEach((c) {
            final leg = c['legs'] as List<dynamic>;
            leg.forEach((d) {
              if (d['duration'] != null) {
                tronson.duration = d['duration']['text'];
              }
              if (d['distance'] != null) {
               // print(d['distance']['text']);
                tronson.distance = d['distance']['text'].toString();
              }
            });
          });
          tronson.cost = tronsonCostWithCar(tronson.distance) as String;
          tronson.origin = origin;
          tronson.destination = destination;
         // print(tronson.cost);
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      }
      return tronson;
    }


    Future<
        Tronson> getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet(
        String origin,
        String destination,
        // String buget,
        // String numberOfPersons,
        // String destinationType,
        // String travelMode
      ) async {
      var trainUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$directionsApiKey&transit_mode=train";
      final results = await client.get(Uri.parse(trainUrl));
      print(results.body);
      final tronson = Tronson();

      if (results.statusCode == 200) {
        final result = json.decode(results.body);
        if (result['status'] == 'OK') {
          final components =
          result['routes'] as List<dynamic>;
          print(components);
          // build result
          components.forEach((c) {
            final leg = c['legs'] as List<dynamic>;
            leg.forEach((d) {
              if (d['duration'] != null) {
                tronson.duration = d['duration']['text'];
              }
              if (d['distance'] != null) {
                print(d['distance']['text']);
                tronson.distance = d['distance']['value'].toString();
              }
            });
          });
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      }
      return tronson;
    }


   //  Future<Fly> getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(
   //      String origin,
   //      String destination,
   //      String buget,
   //      String numberOfPersons,
   //      String departureDate
   //      ) async {
   //
   //
   //
   //    var airUrl = "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=$destination&departureDate=$departureDate&adults=$numberOfPersons&nonStop=false&maxPrice=$buget&max=10";
   //
   //    var resultsFlights = await client.post(
   //      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
   //      body: {
   //        "grant_type": "client_credentials",
   //        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
   //        "client_secret": "rIJW2hknmn7g4o5w",
   //      },
   //    );
   //    print(resultsFlights);
   //    if (resultsFlights.statusCode == 200) {
   //      try {
   //        print(resultsFlights.body);
   //        var security = jsonDecode(resultsFlights.body);
   //        final tronson = Tronson();
   //        print(security);
   //        if (security != null) {
   //          var tokenType = security['token_type'];
   //          print(tokenType);
   //          print(security['access_token']);
   //          var token = security['access_token'];
   //          var bearerToken = '$tokenType ' + '$token';
   //          print("token: " + bearerToken);
   //          var response = await client.get(Uri.parse(airUrl),
   //              headers: {
   //                "Authorization": bearerToken,
   //              });
   //          final result = json.decode(response.body);
   //          print(result);
   //          if (result['status'] == 'OK') {
   //            final components = result['data'] as List<dynamic>;
   //            List<String> departureTime = [];
   //            List<String> depTerminal = [];
   //            List<String> iataCodeDep = [];
   //            List<String> arrivalTime = [];
   //            List<String> arrTerminal = [];
   //            List<String> iataCodeArr = [];
   //            List<String> segDuration = [];
   //            print(components);
   //            components.forEach((d) {
   //              final itinerComp = d['itineraries'] as List<dynamic>;
   //              final segComp = d['itineraries']['segments'] as List<dynamic>;
   //              components.forEach((it) {
   //                for (int i = 0; i < components.length; i++) {
   //                  tronson.duration = it[i]['duration'];
   //                  for (int i = 0; i < segComp.length; i++) {
   //                    components.forEach((seg) {
   //                      for (int i = 0; i < segComp.length; i++) {
   //                        departureTime[i] = seg[i]['departure']['at'];
   //                        depTerminal[i] = seg[i]['departure']['terminal'];
   //                        iataCodeDep[i] = seg[i]['departure']['iataCode'];
   //                        arrivalTime[i] = seg[i]['arrival']['at'];
   //                        arrTerminal[i] = seg[i]['arrival']['terminal'];
   //                        iataCodeArr[i] = seg[i]['arrival']['iataCode'];
   //                        segDuration[i] = seg[i]['duration'];
   //                      }
   //                    });
   //                  }
   //                }
   //              });
   //            });
   //          }
   //        } else {
   //          throw Exception('Failed to fetch suggestion');
   //        }
   //      } catch (e) {
   //        print(e.toString());
   //      }
   //      return fly ;
   //    }
   //
   //
   //    final resultsFlights = await client.get(Uri.parse(airUrl));
   //    print(resultsFlights.body);
   //    final tronson = Tronson();
   //
   //    if (resultsFlights.statusCode == 200) {
   //      final result = json.decode(resultsFlights.body);
   //      if (result['status'] == 'OK') {
   //        final components =
   //        result['routes'] as List<dynamic>;
   //        print(components);
   //        // build result
   //        components.forEach((c) {
   //          final leg = c['legs'] as List<dynamic>;
   //          leg.forEach((d) {
   //            if (d['duration'] != null) {
   //              tronson.duration = d['duration']['text'];
   //            }
   //            if (d['distance'] != null) {
   //              print(d['distance']['text']);
   //              tronson.distance = d['distance']['value'].toString();
   //            }
   //          });
   //        });
   //      } else {
   //        throw Exception('Failed to fetch suggestion');
   //      }
   //    }
   //    return tronson;
   // }

    Future<List<
        Tronson>> getTronsonRouteDetailFromOriginAndDestinationWithIDKInternet(
        String origin,
        String destination,
        String buget,
        String numberOfPersons,
        String destinationType,
        String travelMode) async {
      List<Tronson> travelModeList;
      var driveUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=drive&key=$directionsApiKey";
      var trainUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$directionsApiKey&transit_mode=train";
      var airUrl = "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=LON&departureDate=2022-11-01&adults=2&nonStop=false&maxPrice=700&max=10";
      final results = await Future.wait([
        client.get(Uri.parse(driveUrl)),
        client.get(Uri.parse(trainUrl)),
        client.get(Uri.parse(airUrl)),
      ]);

      //**********
      //* Drive  *
      //**********
      final tronsonCar = Tronson();

      if (results[0].statusCode == 200) {
        final result = json.decode(results[0].body);
        print(result);
        if (result['status'] == 'OK') {
          final components =
          result['routes'] as List<dynamic>;
          print(components);
          // build result
          components.forEach((c) {
            final leg = c['legs'] as List<dynamic>;
            leg.forEach((d) {
              if (d['duration'] != null) {
                tronsonCar.duration = d['duration']['text'];
              }
              if (d['distance'] != null) {
                print(d['distance']['text']);
                tronsonCar.distance = d['distance']['value'].toString();
              }
            });
          });
          tronsonCar.cost = tronsonCostWithCar(tronsonCar.distance) as String;
          tronsonCar.origin = origin;
          tronsonCar.destination = destination;
          print(tronsonCar.cost);
          travelModeList.insert(0, tronsonCar);

          throw Exception(result['error_message']);
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      }
      //**********
      //* Train  *
      //**********
      final tronsonTrain = Tronson();

      if (results[1].statusCode == 200) {
        final result = json.decode(results[1].body);
        if (result['status'] == 'OK') {
          final components =
          result['routes'] as List<dynamic>;
          print(components);
          // build result
          components.forEach((c) {
            final leg = c['legs'] as List<dynamic>;
            leg.forEach((d) {
              if (d['duration'] != null) {
                tronsonTrain.duration = d['duration']['text'];
              }
              if (d['distance'] != null) {
                print(d['distance']['text']);
                tronsonTrain.distance = d['distance']['text'];
              }
            });
          });
          travelModeList.insert(1, tronsonTrain);

          throw Exception(result['error_message']);
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      }
      //**********
      //*   FLY  *
      //**********
      final tronsonFly = Tronson();

      if (results[2].statusCode == 200) {
        final result = json.decode(results[2].body);
        if (result['status'] == 'OK') {
          final components =
          result['routes'] as List<dynamic>;
          print(components);
          // build result
          components.forEach((c) {
            final leg = c['legs'] as List<dynamic>;
            leg.forEach((d) {
              if (d['duration'] != null) {
                tronsonFly.duration = d['duration']['text'];
              }
              if (d['distance'] != null) {
                print(d['distance']['text']);
                tronsonFly.distance = d['distance']['text'];
              }
            });
          });
          travelModeList.insert(2, tronsonFly);

          throw Exception(result['error_message']);
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      }
      return travelModeList;
    }

    Future<Tronson> getTronsonRouteDetailFromOriginAndDestinationInternet(
        String origin,
        String destination,
        String buget,
        String numberOfPersons,
        String destinationType,
        String travelMode) async {

    }
  }