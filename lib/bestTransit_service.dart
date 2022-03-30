import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:geocoding/geocoding.dart' as geolocator;
import 'package:sistem_de_recomandare/travel_service.dart';
import 'package:sistem_de_recomandare/tronson_service.dart';

class BestTransit {
  String id;
  String vehicle;
  String duration;
  String distance;
  String cost;

  BestTransit({
    this.id,
    this.vehicle,
    this.duration,
    this.distance,
    this.cost
  });

  @override
  String toString() {
    return 'Tronson(id: $id, vehicle: $vehicle, duration: $duration, distance:$distance, cost: $cost)';
  }
}

//cost-50%
//time-35%
//efort-15%
//sum_Vehicle=vehicleCost*0.5+vehicleTime*0.35+vehicleEfort*0.15
final directionsApiKey = 'AIzaSyDK2iXHr9XwtIdTIQU9IkBETIM5ivg9PaY';
class BestTransitProvider {

  Future<BestTransit> bestTransitMode(String origin, String destination) async {
    // double pBuget=double.parse(buget)*0.3;  //30% from total buget
    List<double> distanceVector = [];
    List<double> durationVector = [];
    List<double> costVector = [];
    List<String> vehicles = ["Car","Train", "Airplane"];
    List<double> sumVehicle = [];
    List<double> finalSum = [];
    int index;
    BestTransit bestTransit= new BestTransit();
    // print(romaniaAirportsMap.length);
    try {
      final CarDetails = await getDistanceToAirport(
          origin, destination);
      String distanceWithCar = CarDetails.distance.replaceAll("km", "").trim();
      String durationWithCar = CarDetails.duration;

      //var costWithCar = CarDetails.cost;
      print(distanceWithCar);
      print(durationWithCar);
      if (distanceWithCar != null && durationWithCar != null
      ) {
        print("i m hereee");
        distanceVector.add(double.parse(distanceWithCar));
        print(distanceVector);
        durationVector.add(double.parse(durationWithCar));
        print(durationVector[0]*0.5);
        // costVector.add(double.parse(costWithCar));
      }
      // final TrainDetails = await getDistanceToAirport(
      //     origin, destination);
      // var distanceWithTrain = TrainDetails.distance;
      // var durationWithTrain = TrainDetails.duration;
      // //var costWithTrain = TrainDetails.cost;
      // if (distanceWithCar != null && durationWithCar != null
      //    ) {
      //   distanceVector.add(double.parse(distanceWithTrain));
      //   durationVector.add(durationWithTrain);
      //  // costVector.add(double.parse(costWithTrain));
      // }
      // final FlyDetails = await getDistanceToAirport(
      //     origin, destination);
      // var distanceWithAir = FlyDetails.distance;
      // var durationWithAir = FlyDetails.duration;
      // var costWithAir = FlyDetails.cost;
      // if (distanceWithCar != null && durationWithCar != null ) {
      //   distanceVector.add(double.parse(distanceWithAir));
      //   durationVector.add(durationWithAir);
      //   costVector.add(double.parse(costWithAir));
      // }
      for (int i = 0; i < 1; i++) {
        print(i);
        double sum=((distanceVector[i]*0.5)+(durationVector[i]*0.35));
        sumVehicle.add(sum);
        print(sumVehicle);
        //+ double.parse(durationVector[i].replaceAll(new RegExp(r'[^0-9,.]'), '')) * 0.35;
        //finalSum[i]=sumVehicle[i];
        double minimum = sumVehicle.reduce(min);
        if (sumVehicle[i] == minimum) {
          index = i;
        }
      }



      bestTransit.vehicle = vehicles[index];
     // bestTransit.cost = costVector[index] as String;
      bestTransit.duration = durationVector[index].toString();
      bestTransit.distance = distanceVector[index].toString();
      print(bestTransit.vehicle);
      print(bestTransit);
      return bestTransit;
    } catch (e) {
      print(e.toString());
    }
  }
  Future<Tronson> getDistanceToAirport(
      String origin,
      String destination
      ) async {
    var Url = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin &destination=$destination&key=$directionsApiKey";
    final results = await client.get(Uri.parse(Url));
    print(results.body);
    final tronson = Tronson();

    if (results.statusCode == 200) {
      final result = json.decode(results.body);
      if (result['status'] == 'OK') {
        final components =
        result['routes'] as List<dynamic>;
        //print(components);
        // build result
        components.forEach((c) {
          final leg = c['legs'] as List<dynamic>;
          leg.forEach((d) {
            if (d['duration'] != null) {
              tronson.duration = d['duration']['value'].toString();
            }
            if (d['distance'] != null) {
              print(d['distance']['text']);
              tronson.distance = d['distance']['text'].toString();
            }
          });
        });
        // tronson.cost = tronsonCostWithCar(tronson.distance) as String;
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }
    return tronson;
  }

}
