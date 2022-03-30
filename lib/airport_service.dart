
import 'dart:convert';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:sistem_de_recomandare/model/service_locator.dart';
import 'package:sistem_de_recomandare/travel_service.dart';
import 'package:sistem_de_recomandare/tronson_service.dart' as tronson;
import 'package:sistem_de_recomandare/tronson_service.dart';
import 'model/database_manager.dart';
import 'package:geocoding/geocoding.dart' as geolocator;

class Airport {
  String id;
  String name;
  String distance;
  String city;
  String country;
  String iataCode;

  Airport({
    this.id,
    this.name,
    this.distance,
    this.city,
    this.country,
    this.iataCode
  });

  @override
  String toString() {
    return 'Airport(id: $id, name: $name, distance: $distance,city: $city,country: $country,iataCode:$iataCode)';
  }
}


class AirportsList {
  final directionsApiKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';

  void createAirport(
      {String name, String distance,String city, String country, String iataCode}) async {
    Airport airport = Airport(
        id: null,
        name: name,
        distance: distance,
        city: city,
        country: country,
        iataCode: iataCode);

   // await locator<AirportsDatabase>().insertAirport(airport);
  }

}
