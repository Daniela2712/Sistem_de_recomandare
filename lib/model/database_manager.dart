import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sistem_de_recomandare/airport_service.dart';
import 'package:sistem_de_recomandare/model/routes.dart';
import 'package:sistem_de_recomandare/model/tronsons.dart';
import 'package:sistem_de_recomandare/model/users.dart';
import 'package:sistem_de_recomandare/model/hotels.dart';
import 'package:sistem_de_recomandare/model/airports.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_manager.g.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Users])
class UserDatabase extends _$UserDatabase {
  UserDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
  // Get all users
  Future<List<User>> getAllUsers() => select(users).get();

  // Add user
  Future insertUser(User user) => into(users).insert(user);

  // Update user
  Future updateUser(User user) => update(users).replace(user);

  // Delete user
  Future deleteUser(User user) => delete(users).delete(user);
}

@UseMoor(tables: [Tronsons])
class TronsonDatabase extends _$TronsonDatabase {
  TronsonDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
  // Get all users
  Future<List<Tronson>> getAllUsers() => select(tronsons).get();

  // Add user
  Future insertUser(Tronson tronson) => into(tronsons).insert(tronson);

  // Update user
  Future updateUser(Tronson tronson) => update(tronsons).replace(tronson);

  // Delete user
  Future deleteUser(Tronson tronson) => delete(tronsons).delete(tronson);
}

@UseMoor(tables: [Routes])
class RouteDatabase extends _$RouteDatabase {
  RouteDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
  // Get all users
  Future<List<Route>> getAllRoutes() => select(routes).get();

  // Add user
  Future insertRoute(Route route) => into(routes).insert(route);

  // Update user
  Future updateRoute(Route route) => update(routes).replace(route);

  // Delete user
  Future deleteRoute(Route route) => delete(routes).delete(route);
}

@UseMoor(tables: [Hotels])
class HotelDatabase extends _$HotelDatabase {
  HotelDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
  // Get all users
  Future<List<Hotel>> getAllRoutes() => select(hotels).get();

  // Add user
  Future insertRoute(Hotel hotel) => into(hotels).insert(hotel);

  // Update user
  Future updateRoute(Hotel hotel) => update(hotels).replace(hotel);

  // Delete user
  Future deleteRoute(Hotel hotel) => delete(hotels).delete(hotel);
}
@UseMoor(tables: [Airports])
class AirportsDatabase extends _$AirportsDatabase {
  AirportsDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // Get all users
  Future<List<Airport>> getAllRoutes() => select(airports).get();

  // Add user
  Future insertAirport(Airport airport) => into(airports).insert(airport);

  // Update user
  Future updateRoute(Airport airport) => update(airports).replace(airport);

  // Delete user
  Future deleteRoute(Airport airport) => delete(airports).delete(airport);
}