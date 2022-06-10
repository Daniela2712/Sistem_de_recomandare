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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _tripNameController,
                    keyboardType: TextInputType.text,
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
                          hintText: 'Enter your origin address',
                          labelText: 'Origin',
                          contentPadding: EdgeInsets.all(10.0)
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
                          hintText: 'Enter your Destination address',
                          labelText: 'Destination',
                          contentPadding: EdgeInsets.all(10.0)
                      ),
                    ),
                  Column(children: <Widget>[
                    TextField(
                      controller: _dateController, //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                      ),
                     readOnly: true,  //set it true, so that user will not able to edit text
                     onTap: () {
                       _selectDate(context);
                     }
                   //     Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}")
                    )
                   ]
                    ),

                    Row(
                     children:[
                       Expanded(
                       child: Padding(
                           padding: EdgeInsets.only(
                               top: 5
                           ),
                          child: ElevatedButton(
                             onPressed: ()  {
                               navigateToNextActivity(context);
                               SizedBox(
                                 height: 20.0,
                               );

                           },
                           child: Text('Next'),
                          ),
                         ),
                       ),
                      ]
                     )
                  ],
                ),
              ),
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
    NumberFormat formatter = new NumberFormat("00");
    if (selected != null && selected != selectedDate)
      setState(() {
        _dateController.text = "${selectedDate.year}-${formatter.format(selectedDate.month)}-${formatter.format(selectedDate.day)}";
        departure_date=_dateController.text;
        selectedDate=selected;
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
