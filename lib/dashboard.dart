// import 'package:flutter/material.dart';
// import 'package:sistem_de_recomandare/address_search.dart';
// import 'package:sistem_de_recomandare/place_service.dart';
// import 'package:uuid/uuid.dart';
//
// import 'direction_service.dart';
// import 'hotel_service.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Places Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Places Autocomplete Demo'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final _controller = TextEditingController();
//   final _controller2 = TextEditingController();
//   String _streetNumber = '';
//   String _street = '';
//   String _city = '';
//   String _zipCode = '';
//   String _streetNumber_dest = '';
//   String _street_dest = '';
//   String _city_dest = '';
//   String _zipCode_dest = '';
//   String _origin ='';
//   String _destination ='';
//   String _duration ='';
//   String _distance ='';
//   String _hotelName ='';
//   String _hotelDescription ='';
//   String _hotelLocation ='';
//   String _hotelCost ='';
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(left: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               controller: _controller,
//               readOnly: true,
//               onTap: () async {
//                 // generate a new token here
//                 final sessionToken = Uuid().v4();
//                 final Suggestion result = await showSearch(
//                   context: context,
//                   delegate: AddressSearch(sessionToken),
//                 );
//
//                 if (result != null) {
//                   final placeDetails = await PlaceApiProvider(sessionToken)
//                       .getPlaceDetailFromId(result.placeId);
//                   setState(() {
//                     _controller.text = result.description;
//                     _streetNumber = placeDetails.streetNumber;
//                     _street = placeDetails.street;
//                     _city = placeDetails.city;
//                     _zipCode = placeDetails.zipCode;
//                   });
//                 }
//               },
//               decoration: InputDecoration(
//                 icon: Container(
//                   width: 10,
//                   height: 10,
//                   child: Icon(
//                     Icons.search_sharp,
//                     color: Colors.black,
//                   ),
//                 ),
//                 hintText: "Enter your origin address",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
//               ),
//             ),
//
//             SizedBox(height: 20.0),
//             Text('Street Number: $_streetNumber'),
//             Text('Street: $_street'),
//             Text('City: $_city'),
//             Text('ZIP Code: $_zipCode'),
//
//             TextField(
//               controller: _controller2,
//               readOnly: true,
//               onTap: () async {
//                 // generate a new token here
//                 final sessionToken = Uuid().v4();
//                 final Suggestion result = await showSearch(
//                   context: context,
//                   delegate: AddressSearch(sessionToken),
//                 );
//                 // This will change the text displayed in the TextField
//                 if (result != null) {
//                   final placeDetails = await PlaceApiProvider(sessionToken)
//                       .getPlaceDetailFromId(result.placeId);
//                   setState(() {
//                     _controller2.text = result.description;
//                     _streetNumber_dest = placeDetails.streetNumber;
//                     _street_dest = placeDetails.street;
//                     _city_dest = placeDetails.city;
//                     _zipCode_dest = placeDetails.zipCode;
//                   });
//                 }
//               },
//               decoration: InputDecoration(
//                 icon: Container(
//                   width: 10,
//                   height: 10,
//                   child: Icon(
//                     Icons.search_sharp,
//                     color: Colors.black,
//                   ),
//                 ),
//                 hintText: "Enter your destination address",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
//               ),
//             ),
//             TextButton(
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               ),
//               onPressed: () async {
//                 // This will change the text displayed in the TextField
//                 final sessionToken = Uuid().v4();
//                 final hotelDetails = await HotelApiProvider(sessionToken)
//                     .getHotelDetailFromDestination(_controller2.text);
//                 setState(() {
//
//                   _hotelName = hotelDetails.name;
//                   _hotelDescription = hotelDetails.description;
//                   _hotelLocation= hotelDetails.location;
//                   _hotelCost = hotelDetails.cost;
//                 });
//                 SizedBox(height: 20.0);
//
//               },
//               child: Text('See hotel details'),
//             ),
//
//             TextButton(
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               ),
//               onPressed: () async {
//                 // This will change the text displayed in the TextField
//                 final directionDetails = await DirectionApiProvider()
//                     .getDirectionDetailFromOriginAndDestination(_controller.text,_controller2.text);
//                 setState(() {
//
//                   _origin = directionDetails.origin;
//                   _destination = directionDetails.destination;
//                   _duration= directionDetails.duration;
//                   _distance = directionDetails.distance;
//                 });
//                 SizedBox(height: 20.0);
//
//               },
//               child: Text('See route details'),
//             ),
//
//             SizedBox(height: 20.0),
//             // Text('Street Number: $_streetNumber_dest'),
//             // Text('Street: $_street_dest'),
//             // Text('City: $_city_dest'),
//             // Text('ZIP Code: $_zipCode_dest'),
//             // Text(_duration),
//             // Text(_distance)
//              Text('Hotel name: $_hotelName'),
//              Text('Hotel desctiption: $_hotelDescription'),
//              Text('Hotel location: $_hotelLocation'),
//              Text('Hotel cost: $_hotelCost'),
//           ],
//         ),
//       ),
//     );
//   }
// }
