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
    name: "Roman Colosseum, Rome",
    image: "assets/images/rome.jpg",
  ),
  TravelSpot(
    name: "Sagrada Familia, Barcelona",
    image: "assets/images/sagrada_familia.jpg",
  ),
  TravelSpot(
    name: "Liberty Island, New York",
    image: "assets/images/liberty.jpg",
  ),
  TravelSpot(
    name: "Paris",
    image: "assets/images/paris.jpg",
  ),
];

List<User> users = [user1, user2, user3];