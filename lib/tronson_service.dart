import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
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

  TronsonRouteApiProvider(this.sessionToken);

  final sessionToken;

  final directionsApiKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';

  //final response = await client.get(Uri.parse(request));
  Future<Tronson> getTronsonRouteDetailFromOriginAndDestination(String origin,
      String destination,
      String buget, String NumberOfPersons, String destinationType,
      String travelMode) async {
    // setState(() { _showLoading = true; });
    final client = Client();
print("BUNAAAAAAA, SUNT AICIIIIIIIIIII");
    List<Location> location = await locationFromAddress(origin);
    var latitude=location[0].latitude;
    var longitude=location[0].longitude;
    print(latitude);
    var nearestAirportUrl = "https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=1&page%5Boffset%5D=0&sort=distance&sessiontoken=$sessionToken";
    //name, iataCode, cityCode, distance
    final response = await client.get(Uri.parse(nearestAirportUrl));
    print(response.body);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
        result['data'] as List<dynamic>;
        final airportName= result['data']['name'];
        final iataCode= result['data']['iataCode'];
        print(components);
        // build result
        components.forEach((c) {
          final cityCode = c['adress']['cityCode'];
          final distance = c['distance']['value'];

        });

        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }

    var driveUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=drive&key=$directionsApiKey";
    var trainUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$directionsApiKey&transit_mode=train";
    var airUrl = "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=OTP&destinationLocationCode=LON&departureDate=2022-11-01&adults=2&nonStop=false&maxPrice=700&max=10";


    final results = await Future.wait([
      client.get(Uri.parse(driveUrl)),
      client.get(Uri.parse(trainUrl)),
      client.get(Uri.parse(airUrl)),
    ]);
    double tronsonCostWithCar(String distance){

      var consum=6;                                             // 6 litre/100km
      var carburantCost=7;                                      // 7 lei per litre
      var cost=(consum/100)*int.parse(distance)*carburantCost;
      return cost;
    }
    //6l........100km
    //xl........1km
    //x=6*1/100=0.06l


    //**********
    //* Drive  *
    //**********
    if (travelMode=="Drive" && results[0].statusCode == 200) {
      final result = json.decode(results[0].body);
      print(result);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        print(components);
        // build result
        final tronson = Tronson();
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
        tronson.cost=tronsonCostWithCar(tronson.distance) as String;
        // tronson.origin=origin;
        // tronson.destination=destination;
        print(tronson.cost);

        return tronson;

        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    //**********
    //* Train  *
    //**********
    if (travelMode == "Train" && results[1].statusCode == 200) {
      final result = json.decode(results[1].body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        print(components);
        // build result
        final tronson = Tronson();
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration'] != null) {
              tronson.duration = d['duration']['text'];
            }
            if (d['distance'] != null) {
              print(d['distance']['text']);
              tronson.distance = d['distance']['text'];
            }
          });
        });
        return tronson;

        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    //**********
    //*   FLY  *
    //**********
    if (results[2].statusCode == 200) {
      final result = json.decode(results[2].body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        print(components);
        // build result
        final tronson = Tronson();
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration'] != null) {
              tronson.duration = d['duration']['text'];
            }
            if (d['distance'] != null) {
              print(d['distance']['text']);
              tronson.distance = d['distance']['text'];
            }
          });
        });
        return tronson;

        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
  }
}
