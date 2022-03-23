
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

  Future<String> getDistanceToRomanianAirport(String origin) async {
    List romaniaAirportsMap = [
      {
        "name": "Henri Coanda International Airport",
        "city": "Bucharest",
        "country": "Romania",
        "iataCode": "OTP",
      },
      {
        "name": "Cluj Avram Iancu International Airport",
        "city": "Cluj",
        "country": "Romania",
        "iataCode": "CLJ",
      },
      {
        "name": "Iași International Airport",
        "city": "Iasi",
        "country": "Romania",
        "iataCode": "IAS",
      },
      {
        "name": "Oradea International Airport",
        "city": "Oradea",
        "country": "Romania",
        "iataCode": "OMR",
      },
      {
        "name": "Sibiu International Airport",
        "city": "Sibiu",
        "country": "Romania",
        "iataCode": "SBZ",
      },
      {
        "name": "Transilvania Targu Mureș Airport",
        "city": "Targu Mures",
        "country": "Romania",
        "iataCode": "TGM",
      },
      {
        "name": "Timișoara Traian Vuia International Airport",
        "city": "Timisoara",
        "country": "Romania",
        "iataCode": "TSR",
      }
    ];

    int index=0;
    List<int> distanceVector = [];
    // print(romaniaAirportsMap.length);
    for (int i = 0; i <romaniaAirportsMap.length; i++) {
      final distanceTo = await getDistanceToAirport(origin, romaniaAirportsMap[i]["name"]);
      var intStr = distanceTo.distance.replaceAll(new RegExp(r'[^0-9]'), '');
      distanceVector.add(int.parse(intStr));

      int dist=distanceVector[i];
      int minimum=distanceVector.reduce(min);
      print(dist);
      if(dist==minimum)
        index=i;
    }

    print(romaniaAirportsMap[index]["iataCode"]);

    return romaniaAirportsMap[index]["iataCode"];
  }

  Future<tronson.Tronson> getDistanceToAirport(String origin,
      String destination) async {

      return  TronsonRouteApiProvider().getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(origin, destination);

  }


  Future<List<String>> getNearestAirportFromOrigin(String origin) async {
    List<geolocator.Location> location = await locationFromAddress(origin);

    getDistanceToRomanianAirport(origin);

    var latitude = location[0].latitude;
    var longitude = location[0].longitude;
    print(latitude);
    print(longitude);
    var nearestAirportUrl = "https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance";
    var airportName;
    var iataCode;
    var cityCode;
    var distanceAirFromOr;
    List<String> nearestAirDetails;

    var secResponse = await client.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      body: {
        "grant_type": "client_credentials",
        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
        "client_secret": "rIJW2hknmn7g4o5w",
      },
    );
    print(secResponse);
    if (secResponse.statusCode == 200) {
      try {
        print(secResponse.body);
        var security = jsonDecode(secResponse.body);
        print(security);
        if (security != null) {
          var tokenType = security['token_type'];
          print(tokenType);
          print(security['access_token']);
          var token = security['access_token'];
          var bearerToken = '$tokenType ' + '$token';
          print("token: " + bearerToken);
          var response = await client.get(Uri.parse(
              'https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=$latitude&longitude=$longitude&radius=500&page%5Blimit%5D=3&page%5Boffset%5D=0&sort=distance'),
              headers: {
                "Authorization": bearerToken,

              });
          final result = json.decode(response.body);
          print(result);
          if (result['status'] == 'OK') {
            final components = result['data'] as List<dynamic>;
            airportName = result['data']['name'];
            iataCode = result['data']['iataCode'];
            print(components);
            components.forEach((c) {
              cityCode = c['adress']['cityCode'];
              distanceAirFromOr = c['distance']['value'];
            });
            nearestAirDetails.insert(0, airportName);
            nearestAirDetails.insert(1, iataCode);
            nearestAirDetails.insert(2, cityCode);
            nearestAirDetails.insert(3, distanceAirFromOr);
          }
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      } catch (e) {
        print(e.toString());
      }
      print(nearestAirDetails);
      return nearestAirDetails;
    }
  }






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
