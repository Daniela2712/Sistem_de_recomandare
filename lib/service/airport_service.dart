
import 'dart:convert';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:sistem_de_recomandare/model/service_locator.dart';
import 'package:sistem_de_recomandare/travel_service.dart';
import 'package:sistem_de_recomandare/service/tronson_service.dart' as tronson;
import 'package:sistem_de_recomandare/service/tronson_service.dart';
import 'package:sistem_de_recomandare/model/database_manager.dart';
import 'package:geocoding/geocoding.dart' as geolocator;

class Airport {
  String id;
  String name;
  String distance;
  String cityCode;
  String country;
  String iataCode;

  Airport({
    this.id,
    this.name,
    this.distance,
    this.cityCode,
    this.country,
    this.iataCode
  });

  @override
  String toString() {
    return 'Airport(id: $id, name: $name, distance: $distance,city: $cityCode,country: $country,iataCode:$iataCode)';
  }
}

Future<List<Airport>> getNearestAirportFromOrigin(String origin) async {
  List<Location> location = await locationFromAddress(origin);

  var latitude = location[0].latitude;
  var longitude = location[0].longitude;

  var nearestAirportUrl = "https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance";

  List<Airport> nearestAirDetails;
      var secResponse = await client.post(
    Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
    body: {
      "grant_type": "client_credentials",
      "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
      "client_secret": "rIJW2hknmn7g4o5w",
    },
  );
  //https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance
  if (secResponse.statusCode == 200) {
    try {
      var security = jsonDecode(secResponse.body);
      if (security != null) {
        var tokenType = security['token_type'];
        var token = security['access_token'];
        var bearerToken = '$tokenType ' + '$token';
        var response = await client.get(Uri.parse(
            nearestAirportUrl),
            headers: {
              "Authorization": bearerToken,

            });
        final result = json.decode(response.body);
        if (result['status'] == 'OK') {
          final components = result['data'] as List<dynamic>;
          Airport a=new Airport();
          a.name = result['data']['name']?.toString();
          a.iataCode = result['data']['iataCode']?.toString();
          components.forEach((c) {
            a.cityCode = c['adress']['cityCode']?.toString();
            a.distance = c['distance']['value']?.toString();
          });
          nearestAirDetails.add(a);
        }
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } catch (e) {
      print(e.toString());
    }
    return nearestAirDetails;
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
        cityCode: city,
        country: country,
        iataCode: iataCode);

   // await locator<AirportsDatabase>().insertAirport(airport);
  }

}
