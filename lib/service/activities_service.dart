import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:sistem_de_recomandare/travel_service.dart';

import 'hotel_service.dart';


class Activity {
  String id;
  String latitude;
  String longitude;
  String name;
  String description;
  String rating;
  String picture;
  String cost;
  String currency;


  Activity({
    this.id,
    this.latitude,
    this.longitude,
    this.name,
    this.description,
    this.rating,
    this.picture,
    this.cost,
    this.currency
  });

  @override
  String toString() {
    return 'Activity(id: $id, latitude: $latitude, longitude: $longitude, name: $name, description: $description,rating:$rating, picture:$picture, cost:$cost, currency:$currency)';
  }
}
class ActivitiesProviderApi {

  Future<List<List<String>>> getActivitiesForMultipleHotelDestinations(String destination) async {
    List<String> hotelNames = [];
    List<List<String>> activitiesList = [];

    final hotels = await HotelApiProvider().getHotelDetailsFromDestinationInternet(
        destination);

    for (int j = 0; j < hotels.length; j++) {
      hotelNames.add(hotels[j].name);
      print(hotels[j].name);
      List<Location> location = await locationFromAddress(hotels[j].name);
      var latitude = location[0].latitude.toString();
      var longitude = location[0].longitude.toString();
      final activities = await getActivitiesListFromDestinationInternet(
          latitude, longitude);
      print("====================================");
      print(activities);
      print("====================================");
    }

    return activitiesList ;
  }


  Future<List<Activity>> getActivitiesListFromDestinationInternet(String latitude, String longitude) async {
    var airUrl = "https://test.api.amadeus.com/v1/shopping/activities?latitude=$latitude&longitude=$longitude&radius=20&key=NtWb3s6JM63zuZ4q2X5eLg7F7gnRmW5LZLbzfAsxsGmw9RLQE8QVTvyt3wee";

    var resultsFlights = await client.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      body: {
        "grant_type": "client_credentials",
        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
        "client_secret": "rIJW2hknmn7g4o5w",
      },
    );
    //  print(resultsFlights);
    List<Activity> activitiesList = [];
    if (resultsFlights.statusCode == 200) {
      try {
        // print(resultsFlights.body);
        var security = jsonDecode(resultsFlights.body);

        // print(security);
        if (security != null) {
          var tokenType = security['token_type'];
          // print(tokenType);
          // print(security['access_token']);
          var token = security['access_token'];
          var bearerToken = '$tokenType ' + '$token';
          // print("token: " + bearerToken);
          var response = await client.get(Uri.parse(airUrl),
              headers: {
                "Authorization": bearerToken,
              });
          final result = json.decode(response.body);
          // print(result['status']);
          final components = result['data'] as List<dynamic>;
          components.forEach((d) {
            var activity=Activity();
            activity.name=d['name'].toString();
            activity.description=d['shortDescription'].toString();
            activity.latitude=d['geoCode']['latitude'].toString();
            activity.longitude=d['geoCode']['longitude'].toString();
            activity.rating=d['rating'].toString();
            activity.picture=d['pictures'].toString();
            activity.cost=d['price']['amount'].toString();
            activity.currency=d['price']['currencyCode'];
            activitiesList.add(activity);
          });

        } else {
          throw Exception('Failed to fetch suggestion');

        }
      } catch (e) {
        print(e.toString());
      }
      for(int i=0;i<activitiesList.length;i++) {
        print("---------------------------------");
        print(activitiesList[i]);
        print("---------------------------------");
      }
      //print(dataList);
      return activitiesList;
    }
  }
}