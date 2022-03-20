import 'package:moor/moor.dart';

class Airports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get distance => text()();
  TextColumn get city => text()();
  TextColumn get country => text()();
  TextColumn get iataCode=> text()();
}