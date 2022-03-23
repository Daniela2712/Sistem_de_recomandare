import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';


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

    Future<Tronson> getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
        String origin,
        String destination,
        // String buget,
        // String numberOfPersons,
        // String destinationType,
        //String travelMode
        ) async {
      var driveUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=drive&key=$directionsApiKey";
      final response = await client.get(Uri.parse(driveUrl));
      print(response.body);
      final tronson = Tronson();
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print(result);
        if (result['status'] == 'OK') {
          final components =
          result['routes'] as List<dynamic>;
          print(components);
          components.forEach((c) {
            final leg = c['legs'] as List<dynamic>;
            leg.forEach((d) {
              if (d['duration'] != null) {
                tronson.duration = d['duration']['text'];
              }
              if (d['distance'] != null) {
                print(d['distance']['text']);
                tronson.distance = d['distance']['text'].toString();
              }
            });
          });
          tronson.cost = tronsonCostWithCar(tronson.distance) as String;
          tronson.origin = origin;
          tronson.destination = destination;
          print(tronson.cost);
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


    Future<
        Tronson> getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(
        String origin,
        String destination,
        // String buget,
        // String numberOfPersons,
        // String destinationType,
        //String travelMode
        ) async {
      var airUrl = "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$origin&destinationLocationCode=LON&departureDate=2022-11-01&adults=2&nonStop=false&maxPrice=700&max=10";
      final resultsFlights = await client.get(Uri.parse(airUrl));
      print(resultsFlights.body);
      final tronson = Tronson();

      if (resultsFlights.statusCode == 200) {
        final result = json.decode(resultsFlights.body);
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