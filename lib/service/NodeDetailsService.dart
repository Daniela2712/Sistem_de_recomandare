
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NodeDetails {
  String origin;
  String destination;
  String cost;
  String duration;
  String distance;
  String departure_location;
  String departure_time;
  String arrival_location;
  String arrival_time;
  String train_type;
  String agencies_name;
  String stops_number;
  String departure_train;
  String departureTerminal;
  String arrivalTerminal;
  String city;
  String country;
  String name;
  String description;
  String rating;
  String picture;



  NodeDetails({
    this.origin,
    this.destination,
    this.duration,
    this.distance,
    this.cost,
    this.departure_location,
    this.departure_time,
    this.arrival_location,
    this.arrival_time,
    this.train_type,
    this.agencies_name,
    this.stops_number,
    this.departure_train,
    this.departureTerminal,
    this.arrivalTerminal,
    this.city,
    this.country,
    this.name,
    this.description,
    this.rating,
    this.picture,
  });

  @override
  String toString() {
    return 'Hotel(origin: $origin, destination: $destination, duration: $duration, distance:$distance, cost: $cost, departure_location: $departure_location, departure_time: $departure_time, arrival_location: $arrival_location, arrival_time: $arrival_time, train_type: $train_type, agencies_name: $agencies_name, stops_number: $stops_number, departure_train:$departure_train, departureTerminal:$departureTerminal,arrivalTerminal:$arrivalTerminal,country:$country,city:$city)';
  }

  Future<void> postServerInfo() async {

    final authData = {
      'name'   : "blaaaaaaaaaaaaaaaaaaaa",
      'description': "reusit",
    };
    final resp = await http.post(
        Uri.parse(
            'http://192.168.193.66:8080/api/post'),
        headers: { 'content-type' : 'application/json'},
        body: json.encode(authData)
    );

  }



}