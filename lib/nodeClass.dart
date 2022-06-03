
import 'package:http/http.dart' as http;
import 'package:sistem_de_recomandare/service/drive_service.dart';
import 'dart:async';
import 'dart:convert';

import 'model/database_manager.dart';
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
  String adress;
  String contact;
  String checkInDate;
  String checkOutDate;
  String bedType;
  String bedNumber;
  String roomDescription;
  String currency;
  String length;




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
    this.efort,
    this.adress,
    this.contact,
    this.checkInDate,
    this.checkOutDate,
    this.bedType,
    this.bedNumber,
    this.roomDescription,
    this.currency,
    this.length



  });

  @override
  String toString() {
    return 'Node(id: $id, weight: $weight, heuristic: $heuristic, length:$length, origin: $origin, destination: $destination, name: $name, duration: $duration, distance:$distance, cost: $cost, departure_location: $departure_location, departure_time: $departure_time, arrival_location: $arrival_location, arrival_time: $arrival_time, train_type: $train_type, agencies_name: $agencies_name, stops_number: $stops_number, departure_train:$departure_train, departureTerminal:$departureTerminal,arrivalTerminal:$arrivalTerminal,country:$country,city:$city, efort:$efort,adress:$adress,contact:$contact,checkInDate:$checkInDate,checkOutDate:$checkOutDate, bedType:$bedType,bedNumber:$bedNumber,roomDescription:$roomDescription, currency:$currency )';
  }
}
class NodeCalc{
  double calcWeight(Node node){
    double sum;
    sum=double.parse(node.cost)*0.5+double.parse(node.duration?.replaceAll(
        new RegExp(r'[^0-9,.]'), ''))*0.35+double.parse(node.efort)*0.15;
    return sum;
  }

  double hotelWeight(Node node) {
    double sum;
    if(node.currency=="USD"){
      sum=double.parse(node.cost)/double.parse("4.6");
    }
    else if(node.currency=="EUR"){
      sum=double.parse(node.cost)/double.parse("4.94");
    }
    else{
      sum=double.parse(node.cost);
    }
    return sum;
  }
}