// import 'package:flutter/material.dart';
// import 'package:sistem_de_recomandare/place_service.dart';
// import 'package:flutter_gmaps/direction_service.dart';
// class DirectionSearch  {
//   DirectionSearch() {
//     apiClient = DirectionApiProvider();
//   }
//
//   DirectionApiProvider apiClient;
//
//
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return null;
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder(
//       future: query == ""
//           ? null
//           : apiClient.fetchSuggestions(
//           query, 'en'),
//       builder: (context, snapshot) => query == ''
//           ? Container(
//         padding: EdgeInsets.all(16.0),
//         child: Text('Enter your address'),
//       )
//           : snapshot.hasData
//           ? ListView.builder(
//         itemBuilder: (context, index) => ListTile(
//           title:
//           Text((snapshot.data[index] as Suggestion).description),
//           onTap: () {
//             close(context, snapshot.data[index] as Suggestion);
//           },
//         ),
//         itemCount: snapshot.data.length,
//       )
//           : Container(child: Text('Loading...')),
//     );
//   }
// }
