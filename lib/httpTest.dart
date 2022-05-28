import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:sistem_de_recomandare/nodeClass.dart';
import 'package:sistem_de_recomandare/service/drive_service.dart';
import 'package:sistem_de_recomandare/service/fly_service.dart';
import 'package:sistem_de_recomandare/service/transit_service.dart';

class httpService {

  httpService();

  Future<void> fetchServerInfo() async {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAIIIIIIICCCCCCCCCCCCCCCCCCCIIIIIIIIIIII");
    final response = await http.get(
        Uri.parse("http://192.168.193.66:8080/api/products/SONY"));
print(response.statusCode);
    if (response.statusCode == 200) {
      print("BBBBBBBBBBBBBBBBBBBBBBB");

      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      print(responseJson);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Node>> storeNodes() async {
    List<Node> carNodes;
    carNodes = await TronsonRouteApiProviderWithCar().getRouteDetailToRomanianAirportWithCar("Brasov");
    return carNodes;
  }

  Future<void> postServerInfo() async {
    List<Node> carNodes;
    carNodes = await TronsonRouteApiProviderWithCar().getRouteDetailToRomanianAirportWithCar("Brasov");
    List<Node> trainNodes;
    trainNodes = await TronsonRouteApiProviderWithTransit().getRouteDetailToRomanianAirportWithTrain("Brasov");
    List<Node> flyNodes;
    flyNodes = await TronsonRouteApiProviderForFly().getRouteDetailFromAirToDestinationWithAir("MAD");

    var allNodes = [carNodes, trainNodes, flyNodes].expand((x) => x).toList();

    List<String> allWeights=[];
    for(int i=0;i<allNodes.length; i++) {
      allWeights.add(allNodes[i].weight);
    }
    //print(allNodes[32]);
    for(int i=0;i<allWeights.length; i++) {
      final nodeData = {
        'name' : i.toString(),
        'weight': allWeights[i].toString(),
        'heuristic': "0.0"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.134.66:8080/api/post'),
          headers: { 'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }


    // for(int i=0;i<=trainNodes.length; i++) {
    //     final nodeData = {
    //       'name': (i+carNodes.length).toString(),
    //       'weight': trainNodes[i].toString(),
    //       'heuristic': "0.0"
    //     };
    //     final resp = await http.post(
    //         Uri.parse(
    //             'http://192.168.134.66:8080/api/post'),
    //         headers: { 'content-type': 'application/json'},
    //         body: json.encode(nodeData)
    //     );
    // }


    // for(int i=0;i<=flyNodes.length; i++) {
    //   final nodeData = {
    //     'name': (i+flyNodes.length).toString(),
    //     'weight': flyNodes[i].toString(),
    //     'heuristic': "0.0"
    //   };
    //   final resp = await http.post(
    //       Uri.parse(
    //           'http://192.168.134.66:8080/api/post'),
    //       headers: { 'content-type': 'application/json'},
    //       body: json.encode(nodeData)
    //   );
    // }
  }

}