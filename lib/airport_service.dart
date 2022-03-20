
import 'package:sistem_de_recomandare/model/service_locator.dart';
import 'model/database_manager.dart';

class Airport {
  String id;
  String name;
  String distance;
  String city;
  String country;
  String iataCode;

  Airport({
    this.id,
    this.name,
    this.distance,
    this.city,
    this.country,
    this.iataCode
  });

  @override
  String toString() {
    return 'Airport(id: $id, name: $name, distance: $distance,city: $city,country: $country,iataCode:$iataCode)';
  }
}


class AirportsList {

  void createAirport(
      {String name, String distance,String city, String country, String iataCode}) async {
    Airport airport = Airport(
        id: null,
        name: name,
        distance: distance,
        city: city,
        country: country,
        iataCode: iataCode);

   // await locator<AirportsDatabase>().insertAirport(airport);
  }

}
