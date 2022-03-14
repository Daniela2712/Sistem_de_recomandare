import 'package:moor/moor.dart';

class Hotels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get location => text()();
  TextColumn get cost => text()();
}