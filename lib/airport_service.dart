import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:geocoding/geocoding.dart';
class Airport {
  String id;
  String name;
  String distance;
  String city;
  String country;

  Airport({
    this.id,
    this.name,
    this.distance,
    this.city,
    this.country,
  });

  @override
  String toString() {
    return 'Airport(id: $id, name: $name, distance: $distance,city: $city,country: $country)';
  }
}


class AirportApiProvider {
  final client = Client();

  AirportApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyBrLgdXNKKw0FpUspuliQWmjDsR6bpvtRo';
  final apiKey =  androidKey;

  Future<Airport> getNearestAiroportFromOrigin(String origin) async {

    List<Location> locations = await locationFromAddress(origin);
    var originLatitude, originLongitude;
    var destLatitude, destLongitude;
    originLatitude=locations[0].latitude;
    originLongitude=locations[0].longitude;
    destLatitude=locations[0].latitude;
    destLongitude=locations[0].longitude;

    final request =
        'https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$originLatitude&longitude=$originLongitude&radius=500&page%5Blimit%5D=10&page%5Boffset%5D=0&sort=distance';
    final response = await client.get(Uri.parse(request));


    // if (response.statusCode == 200) {
    //   final result = json.decode(response.body);
    //   if (result['status'] == 'OK') {
    //     final components =
    //     result['routes'] as List<dynamic>;
    //     print(components);
    //     // build result
    //     final direction = Tronson();
    //     components.forEach((c) {
    //       final leg = c['legs'] as List<dynamic>;
    //       leg.forEach((d) {
    //         if (d['duration']!=null) {
    //           direction.duration = d['duration']['text'];
    //         }
    //         if (d['distance']!=null) {
    //           print(d['distance']['text']);
    //           direction.distance =d['distance']['text'];
    //         }
    //       });
    //     });
    //     return direction;
    //
    //     throw Exception(result['error_message']);
    //   } else {
    //     throw Exception('Failed to fetch suggestion');
    //   }
    // }
  }
}
