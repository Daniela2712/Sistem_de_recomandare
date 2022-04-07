import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';

class Transit {
  String id;
  String origin;
  String destination;
  String duration;
  String distance;
  String cost;
  String departure_location;
  String departure_time;
  String arrival_location;
  String arrival_time;
  String train_type;
  String agencies_name;
  String stops_number;
  String departure_train;


  Transit({
    this.id,
    this.origin,
    this.destination,
    this.duration,
    this.distance,
    this.cost,
    this.departure_location,
    this.departure_time,
    this.arrival_location,
    this.arrival_time,
    this.train_type,
    this.agencies_name,
    this.stops_number,
    this.departure_train

  });

  @override
  String toString() {
    return 'Transit(id: $id, origin: $origin, destination: $destination, duration: $duration, distance:$distance, cost: $cost, departure_location: $departure_location, departure_time: $departure_time, arrival_location: $arrival_location, arrival_time: $arrival_time, train_type: $train_type, agencies_name: $agencies_name, stops_number: $stops_number, departure_train:$departure_train)';
  }
}


class TronsonRouteApiProviderForTransit {
  final client = Client();

  TronsonRouteApiProviderForTransit();

  final directionsApiKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';

  double tronsonCostWithTrain(String distance, String train_type) {
    double cost;
    String d=distance.replaceAll("km", "").trim();
    double dist=double.parse(d);
    if(train_type=='R'){
      if(dist >=1 && dist <=30){
        cost=8;
      }
      if(dist >=31 && dist <=60){
        cost=11;
      }
      if(dist >=61 && dist <=90){
        cost=18;
      }
      if(dist >=91 && dist <=120){
        cost=24;
      }
      if(dist >=121 && dist <=160){
        cost=32;
      }
      if(dist >=161 && dist <=200){
        cost=39;
      }
      if(dist >=201 && dist <=300){
        cost=52;
      }
      if(dist >=301 && dist <=400){
        cost=69;
      }
      if(dist >=401 && dist <=600){
        cost=101;
      }
      if(dist >=601){
        cost=135;
      }

    }else{
      if(dist >=1 && dist <=30){
        cost=14;
      }
      if(dist >=31 && dist <=60){
        cost=21;
      }
      if(dist >=61 && dist <=90){
        cost=36;
      }
      if(dist >=91 && dist <=120){
        cost=47;
      }
      if(dist >=121 && dist <=160){
        cost=61;
      }
      if(dist >=161 && dist <=200){
        cost=73;
      }
      if(dist >=201 && dist <=300){
        cost=94;
      }
      if(dist >=301 && dist <=400){
        cost=114;
      }
      if(dist >=401 && dist <=600){
        cost=146;
      }
      if(dist >=601){
        cost=175;
      }
    }
    print(cost);
    return cost;
  }

  //6l........100km
  //xl........1km
  //x=6*1/100=0.06l

  Future<List<List<List<String>>>> getRouteDetailToRomanianAirportWithTrain(String origin) async {
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

    List<List<List<String>>> totalDetailsVector = [];
    List<List<String>> tronsonToAirport = [];
    List<String> stepsToAirport = [];
    List<int> counter = [];
    for (int i = 0; i < romaniaAirportsMap.length; i++) {
      tronsonToAirport = [];
      int count=0;
      final distanceTo = await getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet(
          origin, romaniaAirportsMap[i]["name"]);
      print("====================================");
        print(distanceTo);
      print("====================================");
      for (int j = 0; j < distanceTo.length; j++) {
        stepsToAirport = [];
        var intStrDist = distanceTo[j].distance.replaceAll(
            new RegExp(r'[^0-9,.]'), '');
        var intStrDur = distanceTo[j].duration.replaceAll(
            new RegExp(r'[^0-9,.]'), '');

        stepsToAirport.add(intStrDist);
        stepsToAirport.add(intStrDur);
        stepsToAirport.add(distanceTo[j].cost.toString());
        stepsToAirport.add(distanceTo[j].origin);
        stepsToAirport.add(distanceTo[j].destination);
        tronsonToAirport.add(stepsToAirport);

      }
      counter.add(distanceTo.length);
      print("************************************");
      print(tronsonToAirport);
      print("************************************");
      totalDetailsVector.add(tronsonToAirport);
    }
    print(totalDetailsVector);
    print("-----------------------");
    for (int i = 0; i < romaniaAirportsMap.length; i++) {
      for (int j = 0; j < counter[i]; j++) {
        for (int k = 0; k < 5; k++) {
          if(totalDetailsVector[i][j][k] !=null) {
            print(totalDetailsVector[i][j][k]);
          }
        }
      }
      print("-----------------------");
    }

    return totalDetailsVector ;
  }


    Future<List<Transit>>getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet(
      String origin,
      String destination
      ) async {
    var trainUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&mode=transit&key=$directionsApiKey&transit_mode=train";
    final results = await client.get(Uri.parse(trainUrl));
    var transit = Transit();
    List<Transit> stepList=[];
    if (results.statusCode == 200) {
      final result = json.decode(results.body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration'] != null) {
              transit.duration = d['duration']['value'].toString();
            }
            if (d['distance'] != null) {
              transit.distance = d['distance']['text'].toString();
              print(transit.distance);
              //transit.cost = tronsonCostWithTrain(transit.distance, ).toString();
              transit.origin = origin;
              transit.destination = destination;
              transit.cost=0.toString();

            }
            if (d['arrival_time'] != null) {
              transit.arrival_time=d['arrival_time']['value'].toString();
            }
            if (d['departure_time'] != null) {
              transit.departure_time=d['departure_time']['value'].toString();
            }
            if (d['start_address'] != null) {
              transit.departure_location=d['start_address'].toString();
            }
            if (d['end_address'] != null) {
              transit.arrival_location=d['end_address'].toString();
            }
            if (d['steps'] != null) {
            final steps = d['steps'] as List<dynamic>;
            print(steps);
            steps.forEach((e) {
              var step = Transit();
              print("dsdfsdfsdfsdfsfsdf");
             print(e['distance']);
              if (e['distance']!= null) {
                step.distance = e['distance']['text'];
              }
              print(step.distance);
              if (e['duration'] != null) {
                step.duration = e['duration']['text'];
              }
              if (e['html_instructions'] != null) {
                step.departure_train = e['html_instructions'];
              }

              if (e['transit_details'] != null) {
                step.departure_location =
                    e['transit_details']['departure_stop']['name'].toString();
              }
              if (e['transit_details'] != null) {
                step.arrival_location =
                    e['transit_details']['arrival_stop']['name'].toString();
              }
              if (e['transit_details']!= null) {
                step.departure_time =
                    e['transit_details']['departure_time']['text'].toString();
              }
              if (e['transit_details']!= null) {
                step.arrival_time =
                    e['transit_details']['arrival_time']['text'].toString();
              }
              if (e['transit_details']!= null) {
                step.stops_number =
                    e['transit_details']['num_stops'].toString();
              }
              if (e['transit_details'] != null) {
                final line = e['transit_details']['line']['agencies'] as List<
                    dynamic>;
                line.forEach((g) {
                  if (g['name'] != null) {
                    step.agencies_name = g['name'].toString();
                  }
                  if (e['transit_details'] != null) {
                    step.train_type =
                        e['transit_details']['line']['short_name'].toString();
                  }
                });
                step.cost=tronsonCostWithTrain(step.distance, step.train_type).toString();
                // print("COOOOOOOSSSSSSTTTTTT");
                // print(step.cost);
              }
              step.origin=step.departure_location;
              step.destination=step.arrival_location;
              stepList.add(step);
            });
            }

          });
        });
        print("SSSSSSSSSSSSSSSSSSSSSSSSS");
        stepList.add(transit);
        print(stepList);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    return stepList;
  }
}