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

    try {
      final CarDetails = await TronsonRouteApiProvider().getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
          origin, destination);
      String distanceWithCar = CarDetails.distance.replaceAll("km", "").trim();
      String durationWithCar = CarDetails.duration;
      String costWithCar = CarDetails.cost;

      if (distanceWithCar != null && durationWithCar != null && costWithCar!=null
      ) {
        distanceVector.add(double.parse(distanceWithCar));
        durationVector.add(double.parse(durationWithCar));
        costVector.add(double.parse(costWithCar));
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
        double sum=((costVector[i]*0.5)+(durationVector[i]*0.35)+(((distanceVector[i]/100).round())*0.15));
        sumVehicle.add(sum);
        double minimum = sumVehicle.reduce(min);

        if (sumVehicle[i] == minimum) {
          index = i;
        }
      }
      bestTransit.vehicle = vehicles[index];
      bestTransit.cost = costVector[index].toString();
      bestTransit.duration = durationVector[index].toString();
      bestTransit.distance = distanceVector[index].toString();
      return bestTransit;
    } catch (e) {
      print(e.toString());
    }
  }
}
