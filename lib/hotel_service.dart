import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class Hotel {
  String id;
  String name;
  String description;
  String location;
  String cost;

  Hotel({
    this.id,
    this.name,
    this.description,
    this.location,
    this.cost
  });

  @override
  String toString() {
    return 'Route(id: $id, name: $name, description: $description, location: $location, cost: $cost)';
  }
}


class HotelApiProvider {
  final client = Client();

  HotelApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyBrLgdXNKKw0FpUspuliQWmjDsR6bpvtRo';
  final apiKey =  androidKey;

  Future<Hotel> getHotelDetailFromDestination(
      String destination) async {
    // final request =
    //     'https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$apiKey&transit_mode=train';
    final request ='http://192.168.66.66:3000/dataHotelLondon';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      //if (result['status'] == 'OK') {
      //   final components =
      //   result['routes'] as List<dynamic>;
      //   print(components);
      //   // build result
      //   final hotel = Hotel();
      //   components.forEach((c) {
      //     final leg = c['legs'] as List<dynamic>;
      //     leg.forEach((d) {
      //       if (d['duration']!=null) {
      //        // direction.duration = d['duration']['text'];
      //       }
      //       if (d['distance']!=null) {
      //         print(d['distance']['text']);
      //       //  direction.distance =d['distance']['text'];
      //       }
      //     });
       // });
      //  return hotel;

        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
  }
//}
