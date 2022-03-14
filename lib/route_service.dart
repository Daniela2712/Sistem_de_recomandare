import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'model/database_manager.dart';

class Route {
  String id;
  String origin;
  String destination;
  String duration;
  String distance;
  String cost;

  Route({
    this.id,
    this.origin,
    this.destination,
    this.duration,
    this.distance,
    this.cost
  });

  @override
  String toString() {
    return 'Route(id: $id, origin: $origin, destination: $destination, duration: $duration, $distance:distance, cost: $cost)';
  }
}


class RouteApiProvider {
  final client = Client();

  RouteApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyBrLgdXNKKw0FpUspuliQWmjDsR6bpvtRo';
  final apiKey =  androidKey;

  Future<Route> getRouteDetailFromOriginAndDestination(String origin,
      String destination) async {
    final request =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$apiKey&transit_mode=train';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        print(components);
        // build result
        final direction = Route();
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration']!=null) {
              direction.duration = d['duration']['text'];
            }
            if (d['distance']!=null) {
              print(d['distance']['text']);
              direction.distance =d['distance']['text'];
            }
          });
        });
        return direction;

        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
  }
}
