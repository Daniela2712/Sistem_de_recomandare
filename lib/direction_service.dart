import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Direction {
  String duration;
  String distance;
  String origin;
  String destination;

  Direction({
    this.duration,
    this.distance,
    this.origin,
    this.destination,
  });

  @override
  String toString() {
    return 'Direction(duration: $duration, distance: $distance)';
  }
}

class DirectionApiProvider {
  final client = Client();

  DirectionApiProvider();

  static final String androidKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;


  Future<Direction> getDirectionDetailFromOriginAndDestination(String origin,
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
        final direction = Direction();
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
