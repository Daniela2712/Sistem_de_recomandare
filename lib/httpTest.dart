import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';

import 'package:sistem_de_recomandare/nodeClass.dart';
import 'package:sistem_de_recomandare/service/activities_service.dart';
import 'package:sistem_de_recomandare/service/drive_service.dart';
import 'package:sistem_de_recomandare/service/fly_service.dart';
import 'package:sistem_de_recomandare/service/hotel_service.dart';
import 'package:sistem_de_recomandare/service/transit_service.dart';
import 'package:sistem_de_recomandare/travel_service.dart';

class httpService {

  httpService();

  Future<List<int>> fetchServerInfo() async {
    final response = await http.get(
        Uri.parse("http://192.168.134.66:8080/api/aStar"));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      List<int> ids=[];

      final tagName = responseJson.toString();
      final split = tagName.split(', ');
      final Map<int, String> values = {
        for (int i = 1; i < split.length; i++)
          i: split[i]
      };
      print(values);  // {0: grubs, 1:  sheep}

      // final value1 = values[0];
      // final value2 = values[1];
      // final value3 = values[2];

      for(int i=1;i<values.length;i++) {
        ids.add(int.parse(values[i]));
      }
      print(ids);
      return ids;
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Node>> postServerInfo(String trip_name, String origin,String destination, String departure_date,String checkIn_date, String checkOut_date,String nrAdults,String roomQty) async {
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
        "name": "Timișoara Traian Vuia International Airport",
        "city": "Timisoara",
        "country": "Romania",
        "iataCode": "TSR",
      }
    ];

    List<Location> location = await locationFromAddress(destination);
    var latitude = location[0].latitude.toString();
    var longitude = location[0].longitude.toString();

    var url= "http://www.iatageo.com/getCode/$latitude/$longitude";
    final result = await client.get(Uri.parse(url));
    final iataCodeDestination = json.decode(result.body);
    print(iataCodeDestination);
    List<Node> carNode;
    carNode = await TronsonRouteApiProviderWithCar().getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(origin, destination);
    //print(" Node $i : $carNode[i]");

    List<Node> carNodes;
    carNodes = await TronsonRouteApiProviderWithCar().getRouteDetailToRomanianAirportWithCar(origin);
    List<Node> trainNodes;
    trainNodes = await TronsonRouteApiProviderWithTransit().getRouteDetailToRomanianAirportWithTrain(origin);
    List<Node> hotelNode;
    hotelNode = await HotelApiProvider().getHotelDetailsFromDestinationInternet(iataCodeDestination['code'], nrAdults, checkIn_date, checkOut_date, roomQty);
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

    flyNodes1 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[0]["iataCode"],iataCodeDestination['code'],departure_date, nrAdults);
    flyNodes2 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[1]["iataCode"],iataCodeDestination['code'],departure_date, nrAdults);
    flyNodes3 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[2]["iataCode"],iataCodeDestination['code'],departure_date, nrAdults);
    flyNodes4 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[3]["iataCode"],iataCodeDestination['code'],departure_date, nrAdults);
    flyNodes5 = await TronsonRouteApiProviderForFly().getTronsonRouteDetailFromOriginAndDestinationWithAirInternet(romaniaAirportsMap[4]["iataCode"],iataCodeDestination['code'],departure_date, nrAdults);

    print("NUUUUUUUUUUUUUUUUUU");

       try {
        List<Location> location = await locationFromAddress(hotelNode[6]?.name);
        var latitude = location[0].latitude.toString();
        var longitude = location[0].longitude.toString();
        print("NUUUUUUUUUUUUUUUUUU");
        print(latitude);
        print(longitude);
        activitiesNode1 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude, longitude);
        print(activitiesNode1);


        List<Location> location2 = await locationFromAddress(hotelNode[5]?.name);
        var latitude2 = location2[0].latitude.toString();
        var longitude2 = location2[0].longitude.toString();
        activitiesNode2 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude2, longitude2);

        List<Location> location3 = await locationFromAddress(hotelNode[4]?.name);
        var latitude3 = location3[0].latitude.toString();
        var longitude3 = location3[0].longitude.toString();
        activitiesNode3 = await ActivitiesProviderApi().getActivitiesListFromDestinationInternet(
            latitude3, longitude3);
      } catch (e) {
        print(e.toString());
      }

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(activitiesNode1);
    print(activitiesNode2);
    print(activitiesNode3);
    // print(activitiesNode6);
    // print(activitiesNode7);
    // print(activitiesNode8);


    var car = [carNode,carNodes].expand((x) => x).toList();
    var allNodes = [car,trainNodes,flyNodes1,flyNodes2,flyNodes3,flyNodes4,flyNodes5,hotelNode,activitiesNode1,activitiesNode2, activitiesNode3, activitiesNode4, activitiesNode5].expand((x) => x).toList();
    for(int i=0;i<allNodes.length;i++){
      print(" Node $i ");
      print(allNodes[i]);
    }

    final resp = await http.delete(
        Uri.parse('http://192.168.134.66:8080/api/deleteProducts'));

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

    var response= await fetchServerInfo();
    List<Node> listNodes=[];

    if(response.length==5) {
      listNodes.add(allNodes[response[0] - 1]);
      listNodes.add(allNodes[response[1] - 1]);
      listNodes.add(allNodes[response[2] - 1]);
      listNodes.add(allNodes[response[3] - 1]);
      listNodes.add(allNodes[response[4] - 1]);
    }else{
      listNodes.add(allNodes[response[0]-1]);
      listNodes.add(allNodes[response[1]-1]);
      listNodes.add(allNodes[response[2]-1]);
      listNodes.add(allNodes[response[3]-1]);
    }
    print("LISTAAAAAAAAAAAAAAAAAAAAA");
    print(listNodes);
    return listNodes;
  }
}