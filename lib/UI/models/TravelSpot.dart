import 'package:flutter/material.dart';
import 'package:../sistem_de_recomandare/UI/models/User.dart';

class TravelSpot {
  final String name, image;
  //final User rating;

  TravelSpot({
    @required this.name,
    @required this.image,
  });
}

List<TravelSpot> travelSpots = [
  TravelSpot(
    name: "Red Mountains",
    image: "assets/images/Magical_World.png",
  ),
  TravelSpot(
    name: "Megical World",
    image: "assets/images/Magical_World.png",
  ),
  TravelSpot(
   // users: users..shuffle(),
    name: "Red Mountains",
    image: "assets/images/Magical_World.png",
  ),
];

List<User> users = [user1, user2, user3];