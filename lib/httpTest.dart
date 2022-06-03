import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:sistem_de_recomandare/nodeClass.dart';
import 'package:sistem_de_recomandare/service/activities_service.dart';
import 'package:sistem_de_recomandare/service/drive_service.dart';
import 'package:sistem_de_recomandare/service/fly_service.dart';
import 'package:sistem_de_recomandare/service/hotel_service.dart';
import 'package:sistem_de_recomandare/service/transit_service.dart';

class httpService {

  httpService();

  Future<void> fetchServerInfo() async {
    final response = await http.get(
        Uri.parse("http://192.168.193.66:8080/api/products/SONY"));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Node>> storeNodes() async {
    List<Node> carNodes;
    carNodes = await TronsonRouteApiProviderWithCar().getTronsonRouteDetailFromOriginAndDestinationWithCarInternet("Brasov", "Madrid");
    return carNodes;
  }

  Future<void> postServerInfo() async {
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
      // {
      //   "name": "Sibiu International Airport",
      //   "city": "Sibiu",
      //   "country": "Romania",
      //   "iataCode": "SBZ",
      // },
      // {
      //   "name": "Transilvania Targu Mureș Airport",
      //   "city": "Targu Mures",
      //   "country": "Romania",
      //   "iataCode": "TGM",
      // },
      {
        "name": "Timișoara Traian Vuia International Airport",
        "city": "Timisoara",
        "country": "Romania",
        "iataCode": "TSR",
      }
    ];



    List<Node> carNode;
    carNode = await TronsonRouteApiProviderWithCar().getTronsonRouteDetailFromOriginAndDestinationWithCarInternet("Brasov", "London");
    //print(" Node $i : $carNode[i]");

    List<Node> carNodes;
    carNodes = await TronsonRouteApiProviderWithCar().getRouteDetailToRomanianAirportWithCar("London");
    List<Node> trainNodes;
    trainNodes = await TronsonRouteApiProviderWithTransit().getRouteDetailToRomanianAirportWithTrain("London");
    List<Node> hotelNode;
    hotelNode = await HotelApiProvider().getHotelDetailsFromDestinationInternet("LON");
    List<Node> flyNodes1=[];
    List<Node> flyNodes2=[];
    List<Node> flyNodes3=[];
    List<Node> flyNodes4=[];
    List<Node> flyNodes5=[];
    List<Node> activitiesNode1=[];
    List<Node> activitiesNode2=[];
    List<Node> activitiesNode3=[];
    List<Node> activitiesNode4=[];
    List<Node> activitiesNode5=[];
    List<Node> activitiesNode6=[];
    List<Node> activitiesNode7=[];
    List<Node> activitiesNode8=[];
    List<Node> activitiesNode9=[];
    List<Node> activitiesNode10=[];

    flyNodes1 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[0]["iataCode"],"LON");
    flyNodes2 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[1]["iataCode"],"LON");
    flyNodes3 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[2]["iataCode"],"LON");
    flyNodes4 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[3]["iataCode"],"LON");
    flyNodes5 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[4]["iataCode"],"LON");


       try {
        List<Location> location = await locationFromAddress(hotelNode[0]?.name);
        var latitude = location[0].latitude.toString();
        var longitude = location[0].longitude.toString();
        activitiesNode1 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude, longitude);

        List<Location> location2 = await locationFromAddress(hotelNode[1]?.name);
        var latitude2 = location[0].latitude.toString();
        var longitude2 = location[0].longitude.toString();
        activitiesNode2 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude2, longitude2);

        List<Location> location3 = await locationFromAddress(hotelNode[2]?.name);
        var latitude3 = location[0].latitude.toString();
        var longitude3 = location[0].longitude.toString();
        activitiesNode3 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude3, longitude3);

        List<Location> location4 = await locationFromAddress(hotelNode[3]?.name);
        var latitude4 = location[0].latitude.toString();
        var longitude4 = location[0].longitude.toString();
        activitiesNode4 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude4, longitude4);

        List<Location> location5 = await locationFromAddress(hotelNode[4]?.name);
        var latitude5 = location[0].latitude.toString();
        var longitude5 = location[0].longitude.toString();
        activitiesNode5 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude5, longitude5);

        List<Location> location6 = await locationFromAddress(hotelNode[5]?.name);
        var latitude6 = location[0].latitude.toString();
        var longitude6 = location[0].longitude.toString();
        activitiesNode6 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude6, longitude6);

        List<Location> location7 = await locationFromAddress(hotelNode[6]?.name);
        var latitude7 = location[0].latitude.toString();
        var longitude7 = location[0].longitude.toString();
        activitiesNode7 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude7, longitude7);
        List<Location> location8 = await locationFromAddress(hotelNode[7]?.name);
        var latitude8 = location[0].latitude.toString();
        var longitude8 = location[0].longitude.toString();
        activitiesNode8 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude8, longitude8);

        List<Location> location9 = await locationFromAddress(hotelNode[8]?.name);
        var latitude9 = location[0].latitude.toString();
        var longitude9 = location[0].longitude.toString();
        activitiesNode9 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude9, longitude9);

        List<Location> location10 = await locationFromAddress(hotelNode[9]?.name);
        var latitude10 = location[0].latitude.toString();
        var longitude10 = location[0].longitude.toString();
        activitiesNode10 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude10, longitude10);

      } catch (e) {
        print(e.toString());
      }


    var car = [carNode,carNodes].expand((x) => x).toList();
    var allNodes = [car,trainNodes,flyNodes1,flyNodes2,flyNodes3,flyNodes4,flyNodes5,hotelNode,activitiesNode1,activitiesNode2].expand((x) => x).toList();
    for(int i=0;i<allNodes.length;i++){
      print(" Node $i ");
      print(allNodes[i]);
    }
    // print(allNodes[2]);
    // print(allNodes[18]);
    // print(allNodes[36]);
    // print(allNodes[51]);
    // print(allNodes[78]);
    for(int i=0;i<car.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': car[i].weight.toString(),
        'heuristic': "0.0"
      };

      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/carNodes'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
     }

    for(int i=0;i<trainNodes.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': trainNodes[i].weight.toString(),
        'heuristic': "0.0"
      };

      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/trainNodes'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }

    for(int i=0;i<flyNodes1.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': flyNodes1[i].weight.toString(),
        'heuristic': "0.0"
      };


      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/flyNodes1'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<flyNodes2.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': flyNodes2[i].weight.toString(),
        'heuristic': "0.0"
      };


      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/flyNodes2'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<flyNodes3.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': flyNodes3[i].weight.toString(),
        'heuristic': "0.0"
      };


      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/flyNodes3'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<flyNodes4.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': flyNodes4[i].weight.toString(),
        'heuristic': "0.0"
      };


      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/flyNodes4'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<flyNodes5.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': flyNodes5[i].weight.toString(),
        'heuristic': "0.0"
      };


      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/flyNodes5'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<hotelNode.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': hotelNode[i].weight.toString(),
        'heuristic': "0.0"
      };


      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/hotelNodes'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode1.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode1[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode1'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode2.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode2[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode2'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode3.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode3[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode3'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode4.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode4[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode4'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode5.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode5[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode5'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode6.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode6[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode6'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode7.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode7[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode7'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode8.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode8[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode8'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode9.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode9[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode9'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
    for(int i=0;i<activitiesNode10.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': activitiesNode10[i].weight.toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/activitiesNode10'),
          headers: {'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }



  }

}