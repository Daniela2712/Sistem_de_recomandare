// import 'dart:convert';
// import 'dart:core';
// import 'dart:math';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart';
// import 'package:geocoding/geocoding.dart' as geolocator;
// import 'package:sistem_de_recomandare/tronson_service.dart';
//
// class BestTransit {
//   String id;
//   String vehicle;
//   String duration;
//   String distance;
//   String cost;
//
//   BestTransit({
//     this.id,
//     this.vehicle,
//     this.duration,
//     this.distance,
//     this.cost
//   });
//
//   @override
//   String toString() {
//     return 'Tronson(id: $id, vehicle: $vehicle, duration: $duration, $distance:distance, cost: $cost)';
//   }
// }
//
// //cost-50%
// //time-35%
// //efort-15%
// //sum_Vehicle=vehicleCost*0.5+vehicleTime*0.35+vehicleEfort*0.15
// class BestTransitProvider {
//
//   BestTransitProvider();
//
//   Future<BestTransit> bestTransitMode(String origin, String destination, String buget) async {
//     double pBuget=double.parse(buget)*0.3;  //30% from total buget
//     List<int> distanceVector = [];
//     List<int> durationVector = [];
//     List<int> costVector = [];
//     List<String> vehicles = ["Car","Train", "Airplane"];
//     List<double> sumVehicle = [];
//     int index;
//
//     // print(romaniaAirportsMap.length);
//     final CarDetails = await TronsonRouteApiProvider()
//         .getTronsonRouteDetailFromOriginAndDestinationWithCarInternet(
//         origin, destination);
//     var distanceWithCar = CarDetails.distance.replaceAll(
//         new RegExp(r'[^0-9]'), '');
//     var durationWithCar = CarDetails.duration.replaceAll(
//         new RegExp(r'[^0-9]'), '');
//     var costWithCar = CarDetails.cost.replaceAll(new RegExp(r'[^0-9]'), '');
//     distanceVector.add(int.parse(distanceWithCar));
//     durationVector.add(int.parse(durationWithCar));
//     costVector.add(int.parse(costWithCar));
//
//     final TrainDetails = await TronsonRouteApiProvider()
//         .getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet(
//         origin, destination);
//     var distanceWithTrain = TrainDetails.distance.replaceAll(
//         new RegExp(r'[^0-9]'), '');
//     var durationWithTrain = TrainDetails.duration.replaceAll(
//         new RegExp(r'[^0-9]'), '');
//     var costWithTrain = TrainDetails.cost.replaceAll(new RegExp(r'[^0-9]'), '');
//
//     distanceVector.add(int.parse(distanceWithTrain));
//     durationVector.add(int.parse(durationWithTrain));
//     costVector.add(int.parse(costWithTrain));
//
//     final FlyDetails = await TronsonRouteApiProvider()
//         .getTronsonRouteDetailFromOriginAndDestinationWithTrainInternet(
//         origin, destination);
//     var distanceWithAir = FlyDetails.distance.replaceAll(
//         new RegExp(r'[^0-9]'), '');
//     var durationWithAir = FlyDetails.duration.replaceAll(
//         new RegExp(r'[^0-9]'), '');
//     var costWithAir = FlyDetails.cost.replaceAll(new RegExp(r'[^0-9]'), '');
//
//     distanceVector.add(int.parse(distanceWithAir));
//     durationVector.add(int.parse(durationWithAir));
//     costVector.add(int.parse(costWithAir));
//     for(int i=0;i<3;i++){
//       sumVehicle[i]=costVector[i]*0.5+durationVector[i]*0.35;
//       //finalSum[i]=sumVehicle[i];
//       double minimum=sumVehicle.reduce(min);
//       if(sumVehicle[i] ==minimum){
//         index=i;
//       }
//     }
//     BestTransit bestTransit;
//     bestTransit.vehicle=vehicles[index];
//     bestTransit.cost=costVector[index] as String;
//     bestTransit.duration=durationVector[index] as String;
//     bestTransit.distance=distanceVector[index] as String;
//
//     return bestTransit;
//   }
// }
// // int dist=distanceVector[i];
// // int minimum=distanceVector.reduce(min);
// // print(dist);
// // if(dist==minimum)
// // index=i;
// /*
// 0.
// sumVehicle[0]=300[0]*0.5+9[0]*0.35   //25
// minimum=25
// daca 25=25 A
// index=0
//
// 1.
// sumVehicle[1]=100[0]*0.5+3[0]*0.35   //15
// minimum=15
// daca 15=15 A
// index=1
//
// 2.
// sumVehicle[2]=500[0]*0.5+8[0]*0.35   //50
// minimum=15
// daca 15=50 F
// index=1
//
//  */