import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sistem_de_recomandare/travel_service.dart';

class Hotel {
  String id;
  String name;
  String description;
  String adress;
  String cost;
  String contact;
  String checkInDate;
  String checkOutDate;
  String bedType;
  String bedNumber;
  String roomDescription;
  String currency;

  Hotel({
    this.id,
    this.name,
    this.description,
    this.adress,
    this.cost,
    this.contact,
    this.checkInDate,
    this.checkOutDate,
    this.bedType,
    this.bedNumber,
    this.roomDescription,
    this.currency,
  });

  @override
  String toString() {
    return 'Hotel(id: $id, name: $name, description: $description, adress: $adress, cost: $cost,contact: $contact, checkInDate: $checkInDate, checkOutDate: $checkOutDate, bedType: $bedType, bedNumber: $bedNumber, roomDescription: $roomDescription, currency: $currency)';
  }
}


class HotelApiProvider {
  final client = Client();

  HotelApiProvider();

  static final String androidKey = 'AIzaSyBrLgdXNKKw0FpUspuliQWmjDsR6bpvtRo';
  final apiKey =  androidKey;

  Future<List<String>> getDestinationHotelDetail(
      String destination) async {

    List<String> hotelList = [];
    final hotels = await getHotelDetailsFromDestinationInternet(
          destination);
      for (int j = 0; j < hotels.length; j++){
        print(j);
        print(hotels[j]);
        print("====================================");
      }

    return hotelList;
  }


  Future<
      List<Hotel>> getHotelDetailsFromDestinationInternet(
      String destination) async {
    var airUrl = "https://test.api.amadeus.com/v2/shopping/hotel-offers?cityCode=$destination&adults=1&checkInDate=2022-11-20&checkOutDate=2022-11-23&roomQuantity=1";

    var resultsHotels = await client.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      body: {
        "grant_type": "client_credentials",
        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
        "client_secret": "rIJW2hknmn7g4o5w",
      },
    );
    //  print(resultsFlights);
    List<Hotel> hotelList = [];

    if (resultsHotels.statusCode == 200) {
      try {
        // print(resultsFlights.body);
        var security = jsonDecode(resultsHotels.body);
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
            final hotel = Hotel();
            if (d['hotel']['name'] != null) {
              hotel.name = d['hotel']['name'];
            }
            if (d['hotel']['address'] != null) {
              hotel.adress = d['hotel']['address']['lines'].toString();
            }
            if (d['hotel']['contact'] != null) {
              hotel.contact = d['hotel']['contact']['email'].toString();
            }

              final offersComp = d['offers'] as List<dynamic>;
            offersComp.forEach((o) {
                if (o['checkInDate'] != null) {
                  hotel.checkInDate =
                      o['checkInDate'].toString();
                }
                if (o['checkOutDate'] != null) {
                  hotel.checkOutDate =
                      o['checkOutDate'].toString();
                }
                if (o['description'] != null) {
                  hotel.description = o['description']['text'].toString();
                }
                if (o['room'] != null) {
                  hotel.bedType = o['room']['typeEstimated']['bedType'].toString();
                }
                if (o['room'] != null) {
                  hotel.bedNumber = o['room']['typeEstimated']['beds'].toString();
                  hotel.roomDescription = o['room']['description']['text'].toString();
                }
                if (o['price'] != null) {
                  hotel.currency = o['price']['currency'].toString();
                  hotel.cost = o['price']['total'].toString();
                }

                hotelList.add(hotel);
                //print(hotelList);
            });
          });
        } else {
          throw Exception('Failed to fetch suggestion');

        }
      } catch (e) {
        print(e.toString());
      }
      return hotelList;
    }
  }
}