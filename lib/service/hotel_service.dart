import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:sistem_de_recomandare/travel_service.dart';

import '../nodeClass.dart';

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

  Future<List<Node>> getDestinationHotelDetail(
      String destination,
      String adults,
      String checkInDate,
      String checkOutDate,
      String roomQuantity) async {
    String targetHotel;
    List<double> hotelCosts = [];
    List<Node> targetNode=[];
    final hotels = await getHotelDetailsFromDestinationInternet(
        destination,adults, checkInDate, checkOutDate, roomQuantity);
      // for (int j = 0; j < hotels.length; j++){
      //   hotelCosts.add(double.parse(hotels[j].cost));
      // }
      //targetHotel=(hotelCosts).reduce(min).toString();
    for (int j = 0; j < hotels?.length; j++){
      //if((double.parse(hotels[j]?.cost)==double.parse(targetHotel)) && hotels[j] != null){
        targetNode.add(hotels[j]);
        hotels[j].length=hotels.length.toString();
     // }
    }
       return targetNode;
  }


  Future<List<Node>> getHotelDetailsFromDestinationInternet(
      String destination,
      String adults,
      String checkInDate,
      String checkOutDate,
      String roomQuantity,


      ) async {
    var airUrl = "https://test.api.amadeus.com/v2/shopping/hotel-offers?cityCode=$destination&adults=$adults&checkInDate=$checkInDate&checkOutDate=$checkOutDate&roomQuantity=$roomQuantity";

    var resultsHotels = await client.post(
      Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
      body: {
        "grant_type": "client_credentials",
        "client_id": "zHmPH2go7aCsH6qAigzfbvSjNj2EvaA1",
        "client_secret": "rIJW2hknmn7g4o5w",
      },
    );
    List<Hotel> hotelList = [];
    List<Node> hotelNodes = [];

    if (resultsHotels.statusCode == 200) {
      try {
        var security = jsonDecode(resultsHotels.body);
        if (security != null) {
          var tokenType = security['token_type'];
          var token = security['access_token'];
          var bearerToken = '$tokenType ' + '$token';
          var response = await client.get(Uri.parse(airUrl),
              headers: {
                "Authorization": bearerToken,
              });
          final result = json.decode(response.body);
          final components = result['data'] as List<dynamic>;
          components.forEach((d) {
            final hotel = Hotel();
            Node n = new Node();

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
            });
            n.name=hotel.name.toString();
            n.bedNumber=hotel.bedNumber.toString();
            n.contact=hotel.contact.toString();
            n.cost=hotel.cost.toString();
            n.roomDescription=hotel.roomDescription.toString();
            n.currency=hotel.currency.toString();
            n.weight=NodeCalc().hotelWeight(n).toString();
            hotelNodes.add(n);
          });
        } else {
          throw Exception('Failed to fetch suggestion');

        }
      } catch (e) {
        print(e.toString());
      }
      return hotelNodes;
    }
  }
}