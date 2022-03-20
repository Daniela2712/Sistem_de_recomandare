
import 'package:get_it/get_it.dart';
import 'package:sistem_de_recomandare/model/database_manager.dart';

import 'database_manager.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
locator.registerSingleton(UserDatabase(openConnection()));
locator.registerSingleton(HotelDatabase(openConnection()));
locator.registerSingleton(AirportsDatabase(openConnection()));
}