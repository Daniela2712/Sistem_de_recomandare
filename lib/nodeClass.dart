
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'service/NodeDetailsService.dart';

class Node {
  String id;
  String weight;
  String heuristic;
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
  String efort;
  String city;
  String country;
  String name;
  String description;
  String rating;
  String picture;



  Node({
    this.id,
    this.weight,
    this.heuristic,
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
    this.efort


  });

  @override
  String toString() {
    return 'Node(id: $id, weight: $weight, heuristic: $heuristic, origin: $origin, destination: $destination, duration: $duration, distance:$distance, cost: $cost, departure_location: $departure_location, departure_time: $departure_time, arrival_location: $arrival_location, arrival_time: $arrival_time, train_type: $train_type, agencies_name: $agencies_name, stops_number: $stops_number, departure_train:$departure_train, departureTerminal:$departureTerminal,arrivalTerminal:$arrivalTerminal,country:$country,city:$city, efort:$efort)';
  }
}
class NodeCalc{
  double calcWeight(Node node){
    double sum;
    // print(node.distance);
    // print(node.duration);
    // print(node.cost);
    sum=double.parse(node.cost)*0.5+double.parse(node.duration.replaceAll(
        new RegExp(r'[^0-9,.]'), ''))*0.35+(double.parse(node.distance.replaceAll(
        new RegExp(r'[^0-9,.]'), ''))/100).round()*0.15;
    return sum;
  }

}