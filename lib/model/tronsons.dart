import 'package:moor/moor.dart';

class Tronsons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get origin => text()();
  TextColumn get destination => text()();
  TextColumn get duration => text()();
  TextColumn get distance => text()();
  TextColumn get cost => text()();
}