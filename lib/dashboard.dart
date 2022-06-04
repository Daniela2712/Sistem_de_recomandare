import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_de_recomandare/address_search.dart';
import 'package:sistem_de_recomandare/recomandationPage.dart';
import 'package:sistem_de_recomandare/service/hotel_service.dart';
import 'package:sistem_de_recomandare/service/place_service.dart';
import 'package:uuid/uuid.dart';

import 'direction_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class FirstTripInfo extends StatefulWidget {
  // FirstTripInfo({Key key}) : super(key: key);
  //final String idHolder;


  FirstTripInfo();

  @override
  _FirstTripInfoState createState() => _FirstTripInfoState();
}

class _FirstTripInfoState extends State<FirstTripInfo> {
  final _formKey = GlobalKey<FormState>();

  final _originController = TextEditingController();
  final _destinatoionController = TextEditingController();
  final _dateController = TextEditingController();
  final _tripNameController = TextEditingController();

  String city = '';
  String city_dest = '';
  String origin ='';
  String destination ='';
  String trip_name ='';
  String departure_date ='';
  DateTime selectedDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  @override
  void dispose() {
    _originController.dispose();
    _destinatoionController.dispose();
    _dateController.dispose();
    _tripNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip info"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _tripNameController,
              decoration: InputDecoration(
                  hintText: 'Enter your trip name',
                  labelText: 'Name',
                  contentPadding: EdgeInsets.all(10.0)
              ),
            ),

            TextField(
              controller: _originController,
              readOnly: true,
              onTap: () async {
                // generate a new token here
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );

                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(() {
                    _originController.text = result.description;
                    city = placeDetails.city;
                    origin=_originController.text;
                  });
                }
              },
              decoration: InputDecoration(
                icon: Container(
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.search_sharp,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your origin address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),

            TextField(
              controller: _destinatoionController,
              readOnly: true,
              onTap: () async {
                // generate a new token here
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(() {
                    _destinatoionController.text = result.description;
                    city_dest = placeDetails.city;
                    destination=_destinatoionController.text;
                  });
                }
              },
              decoration: InputDecoration(
                icon: Container(
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.search_sharp,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your destination address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),
          Column(children: <Widget>[
              ElevatedButton(
                onPressed: () {
                _selectDate(context);
                },
                child: Text("Choose Date"),
              ),
              Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}")
          ]),

            TextButton(
              onPressed: ()  {
                navigateToNextActivity(context);
                SizedBox(height: 20.0);

              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );

  }
  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        _dateController.text = selected.toString();
        departure_date=_dateController.text;
      });
  }
  navigateToNextActivity(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => UserForm(_tripNameController.text,origin,destination,departure_date)
        )
    );
  }
}
